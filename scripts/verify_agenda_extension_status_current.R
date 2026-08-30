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
  identical(status$a_c_authority$sha256,
            "b331f88b7abb99c03a5a8c657d163d1e006c0cf4cb51e744abcee298ac6af557"),
  "A_C terminal authority hash is pinned"
)
record_check(
  identical(status$a_c_authority$final_gate_manifest_sha256,
            "332d1d7be7a7b38f715c8d7d872c6f7010c22a27fc924b91e8f694199a190fe4"),
  "A_C final gate manifest hash is pinned"
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
    identical(status$a_c_candidate_snapshot$strengthened_candidate_commit,
              "02d217283948fbf430a10491c0907d484dbac3b4") &&
    identical(status$a_c_candidate_snapshot$strengthened_round1_reviews_commit,
              "c21e55425e9209d40d6fd377e0b304c910483054") &&
    identical(status$a_c_candidate_snapshot$strengthened_round1_adjudication_commit,
              "83807b72126f77a354d68f289374f927526d39ee") &&
    identical(status$a_c_candidate_snapshot$repaired_candidate_commit,
              "5410b06b1cb036e53ba2d34830e21425e65f89a0") &&
    identical(status$a_c_candidate_snapshot$repaired_reviews_commit,
              "019dd142c802b516762727dfae61fb65e9598e8f") &&
    identical(status$a_c_candidate_snapshot$repaired_adjudication_commit,
              "f605028e9760b89ea401ce4ad7c4b3d3e90a10e7") &&
    identical(status$a_c_candidate_snapshot$administrative_repair_commit,
              "5785a157d85915ac616f853ee2b314a51da095eb") &&
    identical(status$a_c_candidate_snapshot$administrative_reviews_commit,
              "4575f3781d6bbd92a73589c081bd0b88e0bcb680") &&
    identical(status$a_c_candidate_snapshot$administrative_adjudication_commit,
              "67349a76b01c7cdaff860ee94e2ef4ad36f3422c") &&
    identical(status$a_c_candidate_snapshot$terminal_closure_commit,
              "858e454e9079719dbb521f2cd35cffc3b4a02a13") &&
    identical(status$a_c_candidate_snapshot$candidate_manifest_sha256,
              "ec5bbebe0490eb8a46ee5e0de1565cf52ae1838721a870df21cdc4a629058339") &&
    identical(status$a_c_candidate_snapshot$terminal_gate_candidate_manifest_sha256,
              "17279db1f853e5bc0bb3b7b1ef2411053e1beb6929e56c15b766e0ee847ef5d2") &&
    identical(status$a_c_candidate_snapshot$game_dag_sha256,
              "83245ae3e33b0fd8a29898627aaae40226c9317402e79e1b1375b34aa88a4262") &&
    identical(status$a_c_candidate_snapshot$mechanical_result,
              "1200 PASS / 0 FAIL"),
  "A_C strengthened candidate, mathematical and lifecycle review chain, terminal closure, DAG, and mechanical result are pinned"
)
record_check(
  identical(status$a_r_candidate_snapshot$authorization_commit,
            "c72335ace29fbee9262cbfbd2b843b155a351653") &&
    identical(status$a_r_candidate_snapshot$date_corrected_candidate_commit,
              "aba98f6abcf1b13d2dc386962fb592133a80001f") &&
    identical(status$a_r_candidate_snapshot$interface_repaired_candidate_commit,
              "8215c9f36910a94e251fea4ed8a3be273780a409") &&
    identical(status$a_r_candidate_snapshot$final_candidate_commit,
              "8016dacb79c382d085f23f836a1fdbf8d9b05292") &&
    identical(status$a_r_candidate_snapshot$reviews_and_adjudication_commit,
              "ff9b4617004ca216b5bbed88995cc752f60bf0a9") &&
    identical(status$a_r_candidate_snapshot$candidate_manifest_sha256,
              "b1b483f3c31d58c3cd94807e9b55fd303e795510210914634e29faaee322a6d0") &&
    identical(status$a_r_candidate_snapshot$terminal_gate_candidate_manifest_sha256,
              "f326c7fbf1b70fb66f286a6b9e265b67be76a4385553cbc288d828b0c0386a6f") &&
    identical(status$a_r_candidate_snapshot$mechanical_result,
              "4372 PASS / 0 FAIL"),
  "A_R authorization, three candidate stages, reviews, adjudication, manifests, and mechanical result are pinned"
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
  identical(sha256(status$a_c_authority$path), status$a_c_authority$sha256),
  "A_C terminal authority bytes match"
)
record_check(
  identical(sha256(status$a_c_authority$final_gate_manifest_path),
            status$a_c_authority$final_gate_manifest_sha256),
  "A_C final gate manifest bytes match"
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
record_check(
  identical(sha256(status$a_r_candidate_snapshot$candidate_manifest_path),
            status$a_r_candidate_snapshot$candidate_manifest_sha256),
  "A_R candidate manifest bytes match"
)
record_check(
  identical(sha256(status$a_r_candidate_snapshot$terminal_gate_candidate_manifest_path),
            status$a_r_candidate_snapshot$terminal_gate_candidate_manifest_sha256),
  "A_R terminal-gate candidate manifest bytes match"
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
  identical(ac$status, "pass") && isTRUE(ac$frozen) &&
    identical(ac$authorization, "terminal_author_approval") &&
    identical(ac$mechanical_result, "1200 PASS / 0 FAIL") &&
    identical(ac$review_status,
              "mathematical candidate and lifecycle repair each reviewed twice with PASS 0/0/0; final lifecycle adjudication found no confirmed defects; terminal author approval complete; pass/frozen"),
  "AC is pass/frozen with terminal author approval on the strengthened package"
)
record_check(
  identical(ac$terminal_author_approval$sha256,
            "b331f88b7abb99c03a5a8c657d163d1e006c0cf4cb51e744abcee298ac6af557") &&
    identical(sha256(ac$terminal_author_approval$path),
              ac$terminal_author_approval$sha256) &&
    identical(ac$final_gate_manifest$sha256,
              "332d1d7be7a7b38f715c8d7d872c6f7010c22a27fc924b91e8f694199a190fe4") &&
    identical(ac$final_gate_manifest$entries, 20L) &&
    identical(sha256(ac$final_gate_manifest$path),
              ac$final_gate_manifest$sha256),
  "A_C terminal approval and 20-entry final gate manifest bytes match"
)
record_check(
  identical(ar$status, "reviewed") && identical(ar$frozen, FALSE) &&
    identical(ar$authorization,
              "implementation_and_review_authorized_terminal_approval_pending") &&
    identical(ar$mechanical_result, "4372 PASS / 0 FAIL"),
  "AR is reviewed/unfrozen and still awaits terminal author approval"
)
record_check(
  grepl("^Ok\\.", ar$author_go$literal_decision) &&
    grepl("A_R$", ar$author_go$literal_decision) &&
    identical(sha256(ar$author_go$path), ar$author_go$sha256) &&
    identical(ar$candidate$commit,
              "8016dacb79c382d085f23f836a1fdbf8d9b05292") &&
    identical(ar$candidate$entries, 22L) &&
    identical(sha256(ar$candidate$manifest_path), ar$candidate$manifest_sha256),
  "AR author GO and exact 22-entry candidate snapshot are valid"
)
record_check(
  length(ar$reviews) == 2L &&
    all(vapply(ar$reviews, function(review) {
      identical(review$verdict, "PASS") &&
        identical(review$findings, "0/0/0") &&
        identical(sha256(review$path), review$sha256)
    }, logical(1L))),
  "AR has two byte-valid PASS 0/0/0 independent reviews"
)
record_check(
  identical(ar$adjudication$verdict, "NO_CONFIRMED_DEFECTS") &&
    identical(ar$adjudication$counts$confirmed, 0L) &&
    identical(ar$adjudication$counts$partial, 0L) &&
    identical(ar$adjudication$counts$unresolved, 0L) &&
    identical(sha256(ar$adjudication$markdown_path),
              ar$adjudication$markdown_sha256) &&
    identical(sha256(ar$adjudication$json_path),
              ar$adjudication$json_sha256),
  "AR final adjudication is byte-valid and has no confirmed or unresolved defects"
)
record_check(
  identical(ar$terminal_gate_candidate_manifest$entries, 27L) &&
    identical(sha256(ar$terminal_gate_candidate_manifest$path),
              ar$terminal_gate_candidate_manifest$sha256),
  "AR 27-entry technical terminal-gate candidate is byte-valid"
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
    "abd9b27be4cf1490501e07d0d95ca53a27ae62b492354cb6feb8a633cf021a66",
  "model_redesign/agenda_extension_AC_msb_results.md" =
    "8cadee000f6b8a9f94aff754fdb680f427b731bccf121ae642126a9383693d0a",
  "model_redesign/agenda_extension_AC_msb_interface.json" =
    "ea869c023ce7426dae3b92ffad344b4c79f1f0ce220b8fffaceb011904a85249",
  "model_redesign/agenda_extension_AC_msb_claim_ledger.tsv" =
    "ed49e1f78a77481135b001599c263aeb41bbea106d439cf2f2a660c5c0d1edb1",
  "scripts/verify_agenda_extension_AC_msb.R" =
    "340c5b793b4f509df7e83fc1f9326bbf1b8b9c7d5f17a41056103a32e029b904",
  "quality_reports/verification_outputs/2026-08-30_AC_msb_verifier_output.txt" =
    "0be70231be14e346b252147c51c64714170141b1e7ebf6ae89ddec6c596978e5"
)
for (relative_path in names(expected_a_c_candidate_hashes)) {
  record_check(
    identical(sha256(relative_path),
              unname(expected_a_c_candidate_hashes[[relative_path]])),
    sprintf("A_C candidate bytes match: %s", relative_path)
  )
}
record_check(
  length(ac$authorization_records) == 2L &&
    all(vapply(ac$authorization_records, function(x) {
      identical(sha256(x$path), x$sha256)
    }, logical(1L))) &&
    identical(ac$authorization_records[[2L]]$sha256,
              "131e7485879ffbf1d399f91c2b838fb05e8d64644ae2c393692ffce1888fedec"),
  "A_C start and strengthening authorization bytes match"
)
record_check(
  identical(ac$candidate_manifest$sha256,
            "ec5bbebe0490eb8a46ee5e0de1565cf52ae1838721a870df21cdc4a629058339") &&
    identical(sha256(ac$candidate_manifest$path),
              ac$candidate_manifest$sha256),
  "A_C node record pins the strengthened round-2 candidate manifest"
)

expected_a_c_current_review_hashes <- c(
  "quality_reports/2026-08-30_AC_msb_strengthened_round2_formal_review_1.md" =
    "acf971e9f460f7404a4c681ca1a7a51880c5fbca20870584dc8525e3e21ce4c4",
  "quality_reports/2026-08-30_AC_msb_strengthened_round2_formal_review_2.md" =
    "99a228814a61541015622e85949f4e634a69659f0e7428c4dfa2a95cc12ebcde"
)
a_c_current_review_hashes <- setNames(
  vapply(ac$current_reviews, function(x) x$sha256, character(1L)),
  vapply(ac$current_reviews, function(x) x$path, character(1L))
)
record_check(
  identical(a_c_current_review_hashes[names(expected_a_c_current_review_hashes)],
            expected_a_c_current_review_hashes),
  "A_C strengthened review hashes are pinned"
)
record_check(
  all(vapply(ac$current_reviews, function(x) {
    identical(x$verdict, "PASS") && identical(x$findings, "0/0/0")
  }, logical(1L))),
  "A_C strengthened reviews are recorded as PASS 0/0/0 twice"
)
for (relative_path in names(expected_a_c_current_review_hashes)) {
  record_check(
    identical(sha256(relative_path),
              unname(expected_a_c_current_review_hashes[[relative_path]])),
    sprintf("A_C strengthened review bytes match: %s", relative_path)
  )
}
record_check(
  identical(ac$current_adjudication$verdict, "READY_FOR_IMPLEMENTATION") &&
    identical(ac$current_adjudication$counts$confirmed, 1L) &&
    identical(ac$current_adjudication$counts$partial, 0L) &&
    identical(ac$current_adjudication$counts$unresolved, 0L) &&
    identical(ac$current_adjudication$confirmed_finding,
              "ADJ-AC-STRENGTH-R2-MIN-1") &&
    identical(ac$current_adjudication$repair_status,
              "implemented in the current sidecars and checker") &&
    identical(sha256(ac$current_adjudication$markdown_path),
              ac$current_adjudication$markdown_sha256) &&
    identical(sha256(ac$current_adjudication$json_path),
              ac$current_adjudication$json_sha256),
  "A_C strengthened adjudication and repaired administrative finding are pinned"
)
record_check(
  identical(ac$historical_findings_preserved[[1L]],
            "AC-R1-MIN-1: semantic source_record_ids repaired without changing T1-T5") &&
    any(grepl("AC-STRENGTH-R2-MIN-1", ac$historical_findings_preserved,
              fixed = TRUE)),
  "A_C historical findings remain preserved rather than erased"
)
record_check(
  identical(ac$terminal_gate_candidate_manifest$entries, 13L) &&
    identical(ac$terminal_gate_candidate_manifest$sha256,
              "17279db1f853e5bc0bb3b7b1ef2411053e1beb6929e56c15b766e0ee847ef5d2") &&
    identical(sha256(ac$terminal_gate_candidate_manifest$path),
              ac$terminal_gate_candidate_manifest$sha256),
  "A_C strengthened terminal-gate candidate pins 13 reviewed and adjudicated entries"
)
record_check(
  length(ac$lifecycle_reviews) == 2L &&
    all(vapply(ac$lifecycle_reviews, function(x) {
      identical(x$verdict, "PASS") && identical(x$findings, "0/0/0") &&
        identical(sha256(x$path), x$sha256)
    }, logical(1L))),
  "A_C lifecycle reviews are both pinned as PASS 0/0/0"
)
record_check(
  identical(ac$lifecycle_adjudication$verdict, "NO_CONFIRMED_DEFECTS") &&
    identical(ac$lifecycle_adjudication$counts$confirmed, 0L) &&
    identical(ac$lifecycle_adjudication$counts$partial, 0L) &&
    identical(ac$lifecycle_adjudication$counts$unresolved, 0L) &&
    identical(sha256(ac$lifecycle_adjudication$markdown_path),
              ac$lifecycle_adjudication$markdown_sha256) &&
    identical(sha256(ac$lifecycle_adjudication$json_path),
              ac$lifecycle_adjudication$json_sha256),
  "A_C lifecycle adjudication records no confirmed defects and exact bytes"
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
  any(grepl("A_C.*pass/frozen", status_md, fixed = FALSE, useBytes = TRUE)),
  "human-readable status identifies A_C as pass/frozen"
)
record_check(
  any(grepl("revisado e não congelado", status_md,
            fixed = TRUE, useBytes = TRUE)) &&
    any(grepl("reviewed/unfrozen", status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status identifies A_R as reviewed/unfrozen"
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
  any(grepl("ADJ-AC-STRENGTH-R2-MIN-1", status_md,
            fixed = TRUE, useBytes = TRUE)),
  "human-readable status records the strengthened A_C administrative finding"
)
record_check(
  any(grepl("13/13", status_md, fixed = TRUE, useBytes = TRUE)) &&
    any(grepl("17279db1f853e5bc0bb3b7b1ef2411053e1beb6929e56c15b766e0ee847ef5d2",
              status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status identifies the exact strengthened A_C terminal-gate candidate"
)
record_check(
  any(grepl("20/20", status_md, fixed = TRUE, useBytes = TRUE)) &&
    any(grepl("332d1d7be7a7b38f715c8d7d872c6f7010c22a27fc924b91e8f694199a190fe4",
              status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status identifies the exact A_C final gate"
)
record_check(
  any(grepl("4372 PASS / 0 FAIL", status_md, fixed = TRUE, useBytes = TRUE)) &&
    any(grepl("b1b483f3c31d58c3cd94807e9b55fd303e795510210914634e29faaee322a6d0",
              status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status identifies the exact reviewed A_R candidate"
)
record_check(
  any(grepl("27/27", status_md, fixed = TRUE, useBytes = TRUE)) &&
    any(grepl("f326c7fbf1b70fb66f286a6b9e265b67be76a4385553cbc288d828b0c0386a6f",
              status_md, fixed = TRUE, useBytes = TRUE)),
  "human-readable status identifies the exact A_R terminal-gate candidate"
)

cat(sprintf("SUMMARY | %d PASS | %d FAIL\n", pass_count, fail_count))
if (fail_count > 0L) quit(status = 1L)
