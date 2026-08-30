#!/usr/bin/env Rscript

# Mechanical lifecycle reconciliation check for the agenda extension.
# This script verifies hashes and authorization boundaries. It is not a new
# mathematical review of A_M, A_U, AC, or AR.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 1L) {
  stop("Usage: Rscript scripts/verify_agenda_extension_status_current.R [OUTPUT_PATH]")
}
if (length(args) == 1L) {
  dir.create(dirname(args[[1L]]), recursive = TRUE, showWarnings = FALSE)
  sink(args[[1L]], split = TRUE)
  on.exit(sink(), add = TRUE)
}

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Package 'jsonlite' is required.", call. = FALSE)
}

root <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
status_path <- file.path(root, "model_redesign/agenda_extension_status_current.json")

pass_count <- 0L
fail_count <- 0L

record_check <- function(condition, label) {
  if (isTRUE(condition)) {
    pass_count <<- pass_count + 1L
    cat(sprintf("PASS | %s\n", label))
  } else {
    fail_count <<- fail_count + 1L
    cat(sprintf("FAIL | %s\n", label))
  }
}

sha256 <- function(relative_path) {
  absolute_path <- file.path(root, relative_path)
  if (!file.exists(absolute_path)) return(NA_character_)
  output <- suppressWarnings(system2(
    "shasum",
    c("-a", "256", absolute_path),
    stdout = TRUE,
    stderr = TRUE
  ))
  if (length(output) < 1L) return(NA_character_)
  hash_lines <- grep("^[0-9a-f]{64}", output, value = TRUE)
  if (length(hash_lines) < 1L) return(NA_character_)
  match <- regmatches(hash_lines[[1L]], regexpr("^[0-9a-f]{64}", hash_lines[[1L]]))
  if (length(match) == 0L || identical(match, "")) NA_character_ else match
}

node_by_id <- function(status, node_id) {
  hits <- Filter(function(node) identical(node$node_id, node_id), status$nodes)
  if (length(hits) != 1L) return(NULL)
  hits[[1L]]
}

legacy_a_m_status <- function(relative_path) {
  legacy <- jsonlite::fromJSON(
    file.path(root, relative_path),
    simplifyVector = FALSE
  )
  nodes <- if (!is.null(legacy$nodes)) legacy$nodes else legacy$produced_nodes
  hits <- Filter(function(node) identical(node$node_id, "A_M"), nodes)
  if (length(hits) != 1L) return(NA_character_)
  hits[[1L]]$status
}

record_check(file.exists(status_path), "current structured status exists")
status <- jsonlite::fromJSON(status_path, simplifyVector = FALSE)

record_check(
  identical(status$schema_version, "agenda_extension_lifecycle_status_v1"),
  "status schema is agenda_extension_lifecycle_status_v1"
)
record_check(identical(status$as_of, "2026-08-30"), "status date is pinned")
record_check(
  identical(status$authority$sha256,
            "ca109199060f3aa775f6e2f18ef46fd9cefaff522cc3f7fdeeabfe9d5f412158"),
  "terminal authority hash is pinned"
)
record_check(
  identical(status$authority$final_gate_manifest_sha256,
            "8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e"),
  "final gate manifest hash is pinned"
)
record_check(
  identical(status$a_u_authority$sha256,
            "e330a1956a7c071dc72c2556eda68cf32d2b81473d700100bbf7e1f6e195111b"),
  "A_U terminal authority hash is pinned"
)
record_check(
  identical(status$a_u_authority$final_gate_manifest_sha256,
            "b85741b2176c4480f5f3632c4464a93cebabb5dd4f71636626917b9227030180"),
  "A_U final gate manifest hash is pinned"
)
record_check(
  identical(status$snapshot$candidate_manifest_sha256,
            "4130c09b9a7d504e0dd18f63c8793a0f6ce5f239369c585d924c48742177c0aa"),
  "candidate manifest hash is pinned"
)
record_check(
  identical(status$snapshot$terminal_closure_commit,
            "e191099a378a32bd2192d437455493e5e3300816"),
  "terminal closure commit is pinned"
)
record_check(
  identical(status$a_u_candidate_snapshot$blind_lock_commit,
            "c193f3bdd99c6b127e76e595d851051fa005e247") &&
    identical(status$a_u_candidate_snapshot$adjudicated_candidate_commit,
              "b59ce1bf5b5ee7b57707684de92c38d4fa325b30") &&
    identical(status$a_u_candidate_snapshot$two_layer_substantive_commit,
              "b56085c436eb629c335764eb982d174e5cc2d392") &&
    identical(status$a_u_candidate_snapshot$two_layer_packaged_candidate_commit,
              "34a95f47284296359fa0b9d07dc99e241b42f1ed") &&
    identical(status$a_u_candidate_snapshot$round2_candidate_commit,
              "8e86bab8ea10f75e6fd5aeeb230a9e260479483a") &&
    identical(status$a_u_candidate_snapshot$round2_reviews_commit,
              "0e3b4a8a26f161566562852b4dc8c4320759affa") &&
    identical(status$a_u_candidate_snapshot$round2_adjudication_commit,
              "15dd01fc272e254bde82f86fe093f0ef5d3da69f") &&
    identical(status$a_u_candidate_snapshot$terminal_closure_commit,
              "c34df1afe8b03989336a8f19d840543be2681312") &&
    identical(status$a_u_candidate_snapshot$candidate_manifest_sha256,
              "1c4720e99a1d72ec1533578a141e476679650eded2a333ac3a95f87e7d441b2b"),
  "A_U blind lock, candidates, review and adjudication commits, and round-2 manifest are pinned"
)
record_check(
  identical(status$a_c_candidate_snapshot$authorization_commit,
            "a92175096f0a13340416825510e7b755b64a9c64") &&
    identical(status$a_c_candidate_snapshot$substantive_commit,
              "efeee0264bfe4f80e042bcced3a10dc313a452fe") &&
    identical(status$a_c_candidate_snapshot$round1_packaged_candidate_commit,
              "886c440c4ea882cca42472975e6316c927c86a6e") &&
    identical(status$a_c_candidate_snapshot$round1_reviews_and_adjudication_commit,
              "ddae0df51d99792f8e876dfb89b223a45184dfd7") &&
    identical(status$a_c_candidate_snapshot$traceability_repair_commit,
              "7151b368f1e9d43de30b437ab2386c82655aa789") &&
    identical(status$a_c_candidate_snapshot$round2_packaged_candidate_commit,
              "7248c56cca098d86c0117a78f89c4555c0d934d3") &&
    identical(status$a_c_candidate_snapshot$round2_reviews_and_adjudication_commit,
              "62bad2e6e5d4f360e4c2ae2830916bc02522b512") &&
    identical(status$a_c_candidate_snapshot$administrative_repair_commit,
              "76f4540cacc15a8db6f0175e7056a7692433bec5") &&
    identical(status$a_c_candidate_snapshot$round3_reviews_commit,
              "128860d9f3fd903554b17ad8f343a6211d96cc7d") &&
    identical(status$a_c_candidate_snapshot$round3_adjudication_commit,
              "39268e9d2579b1e072cfa8456a18d30ce89c54de") &&
    identical(status$a_c_candidate_snapshot$candidate_manifest_sha256,
              "fc9788a0a9cd02bb6e059c9f918f4fe5ad7ebdcdb79e210f036684d65602cbba") &&
    identical(status$a_c_candidate_snapshot$terminal_gate_candidate_manifest_sha256,
              "68eeefe86b8ade64266c1c8c9901ef070742aa2821e356371a5736dabfceaf64") &&
    identical(status$a_c_candidate_snapshot$game_dag_sha256,
              "830aedea4d89007353f0b1da9b7ae623b1680360626521f536abedd7fda42b9c") &&
    identical(status$a_c_candidate_snapshot$mechanical_result,
              "941 PASS / 0 FAIL"),
  "A_C authorization, candidate rounds, repairs, reviews, adjudication, terminal-gate candidate, DAG, and mechanical result are pinned"
)

record_check(
  identical(sha256(status$authority$path), status$authority$sha256),
  "terminal authority bytes match"
)
record_check(
  identical(sha256(status$authority$final_gate_manifest_path),
            status$authority$final_gate_manifest_sha256),
  "final gate manifest bytes match"
)
record_check(
  identical(sha256(status$a_u_authority$path), status$a_u_authority$sha256),
  "A_U terminal authority bytes match"
)
record_check(
  identical(sha256(status$a_u_authority$final_gate_manifest_path),
            status$a_u_authority$final_gate_manifest_sha256),
  "A_U final gate manifest bytes match"
)
record_check(
  identical(sha256(status$snapshot$candidate_manifest_path),
            status$snapshot$candidate_manifest_sha256),
  "candidate manifest bytes match"
)
record_check(
  identical(sha256(status$a_u_candidate_snapshot$candidate_manifest_path),
            status$a_u_candidate_snapshot$candidate_manifest_sha256),
  "A_U candidate manifest bytes match"
)
record_check(
  identical(sha256(status$a_c_candidate_snapshot$candidate_manifest_path),
            status$a_c_candidate_snapshot$candidate_manifest_sha256),
  "A_C candidate manifest bytes match"
)
record_check(
  identical(sha256(status$a_c_candidate_snapshot$game_dag_path),
            status$a_c_candidate_snapshot$game_dag_sha256),
  "A_C dependency DAG bytes match"
)
record_check(
  identical(sha256(status$a_c_candidate_snapshot$terminal_gate_candidate_manifest_path),
            status$a_c_candidate_snapshot$terminal_gate_candidate_manifest_sha256),
  "A_C terminal-gate candidate manifest bytes match"
)

a_m <- node_by_id(status, "A_M")
a_u <- node_by_id(status, "A_U")
ac <- node_by_id(status, "AC")
ar <- node_by_id(status, "AR")

record_check(!is.null(a_m), "A_M has exactly one current status record")
record_check(!is.null(a_u), "A_U has exactly one current status record")
record_check(!is.null(ac), "AC has exactly one current status record")
record_check(!is.null(ar), "AR has exactly one current status record")
record_check(
  identical(a_m$status, "pass") && isTRUE(a_m$frozen) &&
    identical(a_m$authorization, "terminal_author_approval"),
  "A_M is pass/frozen with terminal author approval"
)
record_check(
  identical(a_u$status, "pass") && isTRUE(a_u$frozen) &&
    identical(a_u$authorization, "terminal_author_approval"),
  "A_U is pass/frozen with terminal author approval"
)
record_check(
  identical(a_u$equivalence_interface_status,
            "R2-I-1 addressed by A_U-specific Sig_ex_U and Sum_econ_U; reviewed twice with PASS 0/0/0 and independently adjudicated with no confirmed defects"),
  "A_U two-layer interface is recorded as twice reviewed and independently adjudicated"
)
record_check(
  identical(a_u$author_decision$sha256,
            "5f2e3e99c9d14a88097fca3f249ce4212564a31b1cd80902bdb4b11cca2d73ae") &&
    identical(sha256(a_u$author_decision$path), a_u$author_decision$sha256),
  "A_U-specific author decision bytes match"
)
record_check(
  identical(ac$status, "pending") && identical(ac$frozen, FALSE) &&
    identical(ac$authorization, "start_authorized") &&
    identical(ac$mechanical_result, "941 PASS / 0 FAIL") &&
    identical(ac$review_status,
              "mathematical review complete; directed final reviews PASS 0/0/0 twice; NO_CONFIRMED_DEFECTS adjudication complete; terminal author approval pending"),
  "AC is a reviewed and adjudicated pending/unfrozen candidate awaiting terminal author approval"
)
record_check(
  identical(ar$status, "pending") && identical(ar$frozen, FALSE) &&
    identical(ar$authorization, "none"),
  "AR remains pending/unfrozen and unauthorized"
)

expected_frozen_hashes <- c(
  "model_redesign/agenda_extension_A_M_msb_results.md" =
    "7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3",
  "model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv" =
    "321cb2ed45ed1c5ebb6103a4ac567f07b735dd7a2ca8e2252925b43b8a2add9c",
  "scripts/verify_agenda_extension_A_M_msb.R" =
    "b3133ab97870cf9c5730c57da40c2c9f4d68912226bb8d8f080022653e2a8391",
  "quality_reports/verification_outputs/2026-08-29_A_M_msb_two_layer_signature_verifier_output.txt" =
    "3a242732c07b3d6ed5c508ca0238d1665c42de9d4f00f857b4030fe724ce7628"
)

status_frozen_hashes <- setNames(
  vapply(a_m$frozen_artifacts, function(x) x$sha256, character(1L)),
  vapply(a_m$frozen_artifacts, function(x) x$path, character(1L))
)
record_check(
  identical(status_frozen_hashes[names(expected_frozen_hashes)], expected_frozen_hashes),
  "structured status lists the four exact frozen A_M artifact hashes"
)
for (relative_path in names(expected_frozen_hashes)) {
  record_check(
    identical(sha256(relative_path), unname(expected_frozen_hashes[[relative_path]])),
    sprintf("frozen bytes match: %s", relative_path)
  )
}

dependency <- a_m$depends_on[[1L]]
record_check(
  identical(dependency$sha256,
            "ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d") &&
    identical(sha256(dependency$path), dependency$sha256),
  "frozen C_M dependency matches its pinned hash"
)

expected_review_hashes <- c(
  "quality_reports/2026-08-29_A_M_msb_two_layer_signature_formal_review_1.md" =
    "1b71c06b52b26f7455f75d58df1896ffe325f90af6aa24dbef63db331af01519",
  "quality_reports/2026-08-29_A_M_msb_two_layer_signature_formal_review_2.md" =
    "ff78147c2cd20f764d6ba70fee433a925054ac99c80bb32f4b5967e88ebb5cc3"
)
review_hashes <- setNames(
  vapply(a_m$reviews, function(x) x$sha256, character(1L)),
  vapply(a_m$reviews, function(x) x$path, character(1L))
)
record_check(
  identical(review_hashes[names(expected_review_hashes)], expected_review_hashes),
  "structured status lists both exact formal-review hashes"
)
record_check(
  all(vapply(a_m$reviews, function(x) {
    identical(x$verdict, "PASS") && identical(x$findings, "0/0/0")
  }, logical(1L))),
  "both formal reviews are recorded as PASS 0/0/0"
)
for (relative_path in names(expected_review_hashes)) {
  record_check(
    identical(sha256(relative_path), unname(expected_review_hashes[[relative_path]])),
    sprintf("review bytes match: %s", relative_path)
  )
}

expected_a_u_candidate_hashes <- c(
  "model_redesign/agenda_extension_A_U_msb_contract.md" =
    "348ffc702d75e47ec8f8008bccb71338174649f57d90af8fc78e919cfd4ded26",
  "model_redesign/agenda_extension_A_U_msb_results.md" =
    "e2e2ec8cabc3d44b0c72bfa8ae1ef3d35256078448ce688db79bb7c1a96cdc11",
  "model_redesign/agenda_extension_A_U_msb_interface.json" =
    "2ee931d21e3858db6702f78a4636d1f3c4b445910c8160120921c3bfc3b4b317",
  "model_redesign/agenda_extension_A_U_msb_claim_ledger.tsv" =
    "18de37fbadf787f9217f45c9eb5ef31854c75611c9f65ba8130e06a2cd2a34c5",
  "scripts/verify_agenda_extension_A_U_msb.R" =
    "1c4c319fd925b6472612ddd5730ec4ee166af64a555f7aa97e6c930e1ad45fa6",
  "quality_reports/verification_outputs/2026-08-30_A_U_msb_two_layer_verifier_output.txt" =
    "4d30e01cc288e2a66d9e1576df2bd89d478e75a6f447f3a8135fd8b694a7d0f2"
)
a_u_candidate_hashes <- setNames(
  vapply(a_u$frozen_artifacts, function(x) x$sha256, character(1L)),
  vapply(a_u$frozen_artifacts, function(x) x$path, character(1L))
)
record_check(
  identical(a_u_candidate_hashes[names(expected_a_u_candidate_hashes)],
            expected_a_u_candidate_hashes),
  "structured status lists the exact frozen A_U hashes"
)
for (relative_path in names(expected_a_u_candidate_hashes)) {
  record_check(
    identical(sha256(relative_path),
              unname(expected_a_u_candidate_hashes[[relative_path]])),
    sprintf("frozen A_U bytes match: %s", relative_path)
  )
}

expected_a_c_candidate_hashes <- c(
  "model_redesign/agenda_extension_AC_msb_contract.md" =
    "d09958a447cc440586c000f92c10982ae1f786a94845c602d714c6ff284a8b14",
  "model_redesign/agenda_extension_AC_msb_results.md" =
    "479c0089a1ed6a08dc9ffd8061933d248505c9b753a036f812f5b163586d8e77",
  "model_redesign/agenda_extension_AC_msb_interface.json" =
    "103b564bd15af69dbb45c6b57cd16a0228d3c60a24b758ad779f6b75e7fe2cdf",
  "model_redesign/agenda_extension_AC_msb_claim_ledger.tsv" =
    "280f8168cc632fd650e79cc9a4da411b42f24a5f2d845f5e98d337a99ec5ed5b",
  "scripts/verify_agenda_extension_AC_msb.R" =
    "bf69fb434cc05cc53ecab97080989cf2526979c903f17cf0e33c768acb945e51",
  "quality_reports/verification_outputs/2026-08-30_AC_msb_verifier_output.txt" =
    "7d039c00e8ab092b8a3402771062ff83c01d1669e75ab8230b5897b8f530965a"
)
for (relative_path in names(expected_a_c_candidate_hashes)) {
  record_check(
    identical(sha256(relative_path),
              unname(expected_a_c_candidate_hashes[[relative_path]])),
    sprintf("A_C candidate bytes match: %s", relative_path)
  )
}
record_check(
  identical(ac$authorization_record$sha256,
            "ea4e2e9b9e1296aecd64760f058f0097ff4281f6a9b301373feeea2591092f95") &&
    identical(sha256(ac$authorization_record$path),
              ac$authorization_record$sha256),
  "A_C start-authorization bytes match"
)
record_check(
  identical(ac$candidate_manifest$sha256,
            "fc9788a0a9cd02bb6e059c9f918f4fe5ad7ebdcdb79e210f036684d65602cbba") &&
    identical(sha256(ac$candidate_manifest$path),
              ac$candidate_manifest$sha256),
  "A_C node record pins the round-2 candidate manifest"
)

expected_a_c_round2_review_hashes <- c(
  "quality_reports/2026-08-30_AC_msb_round2_formal_review_1.md" =
    "085db057eb9275b9cd8a6084d7a923c6bc0e4710ba5f3091622d3ebda3d0cd6f",
  "quality_reports/2026-08-30_AC_msb_round2_formal_review_2.md" =
    "872522eddae4b8af886a9d31197a4b6f1014bf14234841c4575a123cdc84d0ee"
)
a_c_round2_review_hashes <- setNames(
  vapply(ac$current_reviews, function(x) x$sha256, character(1L)),
  vapply(ac$current_reviews, function(x) x$path, character(1L))
)
record_check(
  identical(a_c_round2_review_hashes[names(expected_a_c_round2_review_hashes)],
            expected_a_c_round2_review_hashes),
  "A_C round-2 review hashes are pinned"
)
record_check(
  identical(ac$current_reviews[[1L]]$verdict, "PASS") &&
    identical(ac$current_reviews[[1L]]$findings, "0/0/0") &&
    identical(ac$current_reviews[[2L]]$verdict, "FAIL") &&
    identical(ac$current_reviews[[2L]]$findings, "0/0/1"),
  "A_C round-2 review divergence is preserved exactly"
)
for (relative_path in names(expected_a_c_round2_review_hashes)) {
  record_check(
    identical(sha256(relative_path),
              unname(expected_a_c_round2_review_hashes[[relative_path]])),
    sprintf("A_C round-2 review bytes match: %s", relative_path)
  )
}
record_check(
  identical(ac$current_adjudication$verdict, "READY_FOR_IMPLEMENTATION") &&
    identical(ac$current_adjudication$confirmed_finding, "AC-R2-MIN-1") &&
    identical(sha256(ac$current_adjudication$markdown_path),
              ac$current_adjudication$markdown_sha256) &&
    identical(sha256(ac$current_adjudication$json_path),
              ac$current_adjudication$json_sha256),
  "A_C round-2 adjudication and confirmed administrative finding are pinned"
)
record_check(
  identical(ac$previous_review_round$confirmed_finding, "AC-R1-MIN-1") &&
    identical(ac$previous_review_round$adjudication_verdict,
              "READY_FOR_IMPLEMENTATION"),
  "A_C round-1 traceability finding is preserved as historical and repaired"
)
record_check(
  identical(ac$administrative_repair_status,
            "AC-R2-MIN-1 implemented and independently verified twice with PASS 0/0/0; final adjudication found no current defect"),
  "A_C administrative repair is independently verified without terminal approval"
)
expected_a_c_round3_review_hashes <- c(
  "quality_reports/2026-08-30_AC_msb_round3_formal_review_1.md" =
    "83e6a4a7249f666fb0760ed33b43c3fbff710f39476ef63791f4a9ae55b1c989",
  "quality_reports/2026-08-30_AC_msb_round3_formal_review_2.md" =
    "c515bfef9efd594d947bc76b660046f4784dd66de69b9929598a459ad86fdedf"
)
a_c_round3_review_hashes <- setNames(
  vapply(ac$directed_final_reviews, function(x) x$sha256, character(1L)),
  vapply(ac$directed_final_reviews, function(x) x$path, character(1L))
)
record_check(
  identical(a_c_round3_review_hashes[names(expected_a_c_round3_review_hashes)],
            expected_a_c_round3_review_hashes) &&
    all(vapply(ac$directed_final_reviews, function(x) {
      identical(x$verdict, "PASS") && identical(x$findings, "0/0/0")
    }, logical(1L))),
  "A_C directed final reviews are pinned as PASS 0/0/0 twice"
)
for (relative_path in names(expected_a_c_round3_review_hashes)) {
  record_check(
    identical(sha256(relative_path),
              unname(expected_a_c_round3_review_hashes[[relative_path]])),
    sprintf("A_C directed final review bytes match: %s", relative_path)
  )
}
record_check(
  identical(ac$directed_final_adjudication$verdict,
            "NO_CONFIRMED_DEFECTS") &&
    identical(ac$directed_final_adjudication$counts$confirmed, 0L) &&
    identical(ac$directed_final_adjudication$counts$partial, 0L) &&
    identical(ac$directed_final_adjudication$counts$unresolved, 0L) &&
    identical(sha256(ac$directed_final_adjudication$markdown_path),
              ac$directed_final_adjudication$markdown_sha256) &&
    identical(sha256(ac$directed_final_adjudication$json_path),
              ac$directed_final_adjudication$json_sha256),
  "A_C directed final adjudication records no current confirmed, partial, or unresolved defect"
)
record_check(
  identical(ac$terminal_gate_candidate_manifest$entries, 12L) &&
    identical(ac$terminal_gate_candidate_manifest$sha256,
              "68eeefe86b8ade64266c1c8c9901ef070742aa2821e356371a5736dabfceaf64") &&
    identical(sha256(ac$terminal_gate_candidate_manifest$path),
              ac$terminal_gate_candidate_manifest$sha256),
  "A_C terminal-gate candidate pins 12 reviewed and adjudicated entries"
)

expected_a_u_review_hashes <- c(
  "quality_reports/2026-08-29_A_U_msb_formal_review_1.md" =
    "36e1e092ff2135e5610b2d942a81b7955ed899702ae266986ca2c712659f380d",
  "quality_reports/2026-08-29_A_U_msb_formal_review_2.md" =
    "79a335f6557b4274786256011cc850fbf8dd81e606b43ef7f2d04d951aa4ea57"
)
record_check(
  length(a_u$current_reviews) == 2L && !is.null(a_u$current_adjudication),
  "A_U round-2 candidate has two current reviews and a current adjudication"
)
expected_a_u_round2_review_hashes <- c(
  "quality_reports/2026-08-30_A_U_msb_two_layer_round2_formal_review_1.md" =
    "6432708aabe1694603c99eb8df4e8b1ecda196ef8df8244128fd1b8f20c5be75",
  "quality_reports/2026-08-30_A_U_msb_two_layer_round2_formal_review_2.md" =
    "3ae8bcf4e858f10784a25d548526a88f8d66469428c7c7ab0195704659458b84"
)
a_u_round2_review_hashes <- setNames(
  vapply(a_u$current_reviews, function(x) x$sha256, character(1L)),
  vapply(a_u$current_reviews, function(x) x$path, character(1L))
)
record_check(
  identical(a_u_round2_review_hashes[names(expected_a_u_round2_review_hashes)],
            expected_a_u_round2_review_hashes) &&
    all(vapply(a_u$current_reviews, function(x) {
      identical(x$verdict, "PASS") && identical(x$findings, "0/0/0")
    }, logical(1L))),
  "A_U round-2 reviews are both pinned as PASS 0/0/0"
)
for (relative_path in names(expected_a_u_round2_review_hashes)) {
  record_check(
    identical(sha256(relative_path),
              unname(expected_a_u_round2_review_hashes[[relative_path]])),
    sprintf("A_U round-2 review bytes match: %s", relative_path)
  )
}
record_check(
  identical(a_u$current_adjudication$verdict, "NO_CONFIRMED_DEFECTS") &&
    identical(a_u$current_adjudication$counts$confirmed, 0L) &&
    identical(a_u$current_adjudication$counts$partial, 0L) &&
    identical(a_u$current_adjudication$counts$unresolved, 0L),
  "A_U round-2 adjudication records no confirmed, partial, or unresolved defects"
)
record_check(
  identical(sha256(a_u$current_adjudication$markdown_path),
            a_u$current_adjudication$markdown_sha256),
  "A_U round-2 adjudication Markdown bytes match"
)
record_check(
  identical(sha256(a_u$current_adjudication$json_path),
            a_u$current_adjudication$json_sha256),
  "A_U round-2 adjudication JSON bytes match"
)
record_check(
  identical(a_u$previous_review_round$review_1, "PASS 0/0/0") &&
    identical(a_u$previous_review_round$review_2, "FAIL 0/1/0") &&
    identical(a_u$previous_review_round$confirmed_finding, "R2-I-1"),
  "historical A_U review divergence is preserved separately"
)
for (relative_path in names(expected_a_u_review_hashes)) {
  record_check(
    identical(sha256(relative_path),
              unname(expected_a_u_review_hashes[[relative_path]])),
    sprintf("A_U review bytes match: %s", relative_path)
  )
}

record_check(
  identical(a_u$previous_review_round$adjudication_verdict, "BLOCKED") &&
    identical(a_u$previous_review_round$confirmed_finding, "R2-I-1") &&
    identical(a_u$previous_review_round$json_sha256,
              "460780c0f694969f2f1566cbc913d797d8c25e6e2e48f47a047c89fddceb749b"),
  "historical A_U adjudication boundary is preserved"
)
record_check(
  identical(sha256("quality_reports/adjudication/A_U_msb/b59ce1bf5b5/adjudication_round1.md"),
            "bce0b8fb1abe75a39e8a9a857653a6f328a5dc00f2e264d3805ec8b927fad5ad"),
  "A_U adjudication Markdown bytes match"
)
record_check(
  identical(sha256(a_u$previous_review_round$json_path),
            a_u$previous_review_round$json_sha256),
  "A_U adjudication JSON bytes match"
)

record_check(
  identical(a_m$adjudication$verdict, "NO_CONFIRMED_DEFECTS") &&
    identical(a_m$adjudication$counts$confirmed, 0L) &&
    identical(a_m$adjudication$counts$partial, 0L) &&
    identical(a_m$adjudication$counts$unresolved, 0L),
  "adjudication verdict and zero counts are preserved"
)
record_check(
  identical(sha256(a_m$adjudication$markdown_path),
            a_m$adjudication$markdown_sha256),
  "adjudication Markdown bytes match"
)
record_check(
  identical(sha256(a_m$adjudication$json_path),
            a_m$adjudication$json_sha256),
  "adjudication JSON bytes match"
)

expected_legacy_hashes <- c(
  "model_redesign/agenda_extension_game_dag.json" =
    "9644151b8441ed5d09d1a870c3a2f5b94437c2376c7af6fb419c17297ebd5cd6",
  "model_redesign/agenda_extension_game_dag_simplified.json" =
    "a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0",
  "scripts/verify_agenda_extension_A_M_mechanical.R" =
    "1512fe8b31b65d44ef58fcbba2c58e345e3631f767aac9a0f363f897c7d28747"
)
legacy_hashes <- setNames(
  vapply(status$legacy_status_sources, function(x) x$sha256, character(1L)),
  vapply(status$legacy_status_sources, function(x) x$path, character(1L))
)
record_check(
  identical(legacy_hashes[names(expected_legacy_hashes)], expected_legacy_hashes),
  "structured status pins the preserved legacy sources"
)
for (relative_path in names(expected_legacy_hashes)) {
  record_check(
    identical(sha256(relative_path), unname(expected_legacy_hashes[[relative_path]])),
    sprintf("legacy provenance bytes remain unchanged: %s", relative_path)
  )
}
record_check(
  identical(legacy_a_m_status("model_redesign/agenda_extension_game_dag.json"), "pending"),
  "pre-M/S/B DAG still records its historical A_M pending state"
)
record_check(
  identical(legacy_a_m_status("model_redesign/agenda_extension_game_dag_simplified.json"), "pending"),
  "simplified pre-M/S/B DAG still records its historical A_M pending state"
)

record_check(
  identical(status$downstream$authorization, "none") &&
    identical(status$downstream$manuscript_migration_authorized, FALSE) &&
    identical(status$downstream$tag_authorized, FALSE) &&
    identical(status$downstream$merge_authorized, FALSE) &&
    identical(status$downstream$push_authorized, FALSE),
  "no downstream, manuscript, tag, merge, or push authorization is introduced"
)

status_md <- readLines(
  file.path(root, status$human_readable_status),
  warn = FALSE,
  encoding = "UTF-8"
)
record_check(
  any(grepl("A_M.*pass/frozen", status_md, fixed = FALSE, useBytes = TRUE)),
  "human-readable status identifies A_M as pass/frozen"
)
record_check(
  any(grepl("A_U.*pass/frozen", status_md, fixed = FALSE, useBytes = TRUE)),
  "human-readable status identifies A_U as pass/frozen"
)
record_check(
  any(grepl("A_C.*pending/unfrozen", status_md, fixed = FALSE, useBytes = TRUE)),
  "human-readable status identifies A_C as pending/unfrozen"
)
record_check(
  any(grepl("R2-I-1", status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status records the confirmed A_U interface finding"
)
record_check(
  any(grepl("NO_CONFIRMED_DEFECTS", status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status records the clean A_U round-2 adjudication"
)
record_check(
  any(grepl("AC-R2-MIN-1", status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status records the confirmed A_C administrative finding"
)
record_check(
  any(grepl("12/12", status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status identifies the exact A_C terminal-gate candidate"
)

cat(sprintf("SUMMARY | %d PASS | %d FAIL\n", pass_count, fail_count))
if (fail_count > 0L) quit(status = 1L)
