terraform {
    source = "../../../aws//S3"
  }

include {
    path = find_in_parent_folders()
  }