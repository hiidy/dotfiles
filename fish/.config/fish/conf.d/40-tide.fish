status is-interactive; or exit 0

# Prompt layout
set -g tide_left_prompt_items pwd git newline character
set -g tide_right_prompt_items status cmd_duration context jobs direnv go terraform docker gcloud kubectl

# Global prompt behavior
set -g tide_prompt_add_newline_before true
set -g tide_prompt_pad_items false
set -g tide_prompt_min_cols 26
set -g tide_left_prompt_frame_enabled false
set -g tide_right_prompt_frame_enabled false

# PWD: anchor project roots so they survive truncation
set -g tide_pwd_markers \
    .git \
    go.work go.mod \
    .terraform .terraform.lock.hcl terragrunt.hcl \
    kustomization.yaml Chart.yaml skaffold.yaml cloudbuild.yaml

# Git: keep long branch names useful when prefixes repeat.
set -g tide_git_truncation_length 40
set -g tide_git_truncation_strategy l

# Command duration: only show if >= 3s
set -g tide_cmd_duration_threshold 3000
