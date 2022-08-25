locals {
  count_map = {
    stage = 1
    prod = 2
  }

  bucket_ids = toset([
    "bucket1",
    "bucket2",
  ])
}

resource "yandex_storage_bucket" "bucket-per-count" {
  bucket     = "yam-test-${count.index}-${terraform.workspace}"
  access_key = "${var.YC_S3_KEY_ID}"
  secret_key = "${var.YC_S3_SECRET_KEY}"
  count = local.count_map[terraform.workspace]
}

resource "yandex_storage_bucket" "bucket-per-foreach" {
  for_each = local.bucket_ids
  bucket     = "yam-test-${each.key}-${terraform.workspace}"
  access_key = "${var.YC_S3_KEY_ID}"
  secret_key = "${var.YC_S3_SECRET_KEY}"
}

