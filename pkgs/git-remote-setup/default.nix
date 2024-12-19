{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "git-remote-setup" ''
      #!/usr/bin/env bash
      # Get the current directory name
      REPO_NAME=$(basename "$(pwd)")

      # Function to check if the script is run inside a git repository
      check_git_repo() {
          if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
              echo "Error: Not inside a git repository. Please run this script in a git repository."
              exit 1
          fi
      }

      # Function to add remotes
      add_remotes() {
          # Remove existing remotes if they exist
          git remote remove origin 2>/dev/null
          git remote remove codeberg 2>/dev/null
          git remote remove github 2>/dev/null

          # Add Codeberg remote
          git remote add codeberg git@codeberg.org:iamzenz/"${REPO_NAME}".git

          # Add GitHub remote
          git remote add github git@github.com:iamzenz/"${REPO_NAME}".git

          # Verify remotes
          echo "Remotes added successfully:"
          git remote -v
      }

      # Main script execution
      main() {
          check_git_repo
          add_remotes
      }

      # Run the main function
      main
    '')
  ];
  # Your custom nix-package
  # ...
}
