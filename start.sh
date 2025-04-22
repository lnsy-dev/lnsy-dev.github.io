#!/bin/bash

# Exit script if any command fails
set -e

echo "Starting Jekyll development server with live reload..."

# Set up Ruby environment safely (without sudo)
setup_ruby_env() {
  # Check if Homebrew is installed
  if command -v brew &> /dev/null; then
    echo "Setting up Ruby environment using Homebrew..."
    
    # Check if Ruby is installed via Homebrew
    if ! brew list ruby &> /dev/null; then
      echo "Installing Ruby via Homebrew..."
      brew install ruby
    fi
    
    # Add Homebrew Ruby to PATH if needed
    if [[ ":$PATH:" != *":/opt/homebrew/opt/ruby/bin:"* ]]; then
      export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
      export GEM_HOME="$HOME/.gem"
      export PATH="$GEM_HOME/bin:$PATH"
    fi
  else
    echo "Homebrew not found. Installing Ruby environment may require sudo permissions."
    echo "Consider installing Homebrew (https://brew.sh/) for a safer Ruby setup."
  fi
  
  # Install bundler if needed
  if ! command -v bundle &> /dev/null; then
    echo "Installing Bundler..."
    gem install bundler
  fi
  
  # Install dependencies if needed
  if [ ! -d "vendor/bundle" ]; then
    echo "Installing Jekyll dependencies locally..."
    bundle config set --local path 'vendor/bundle'
    bundle install
  fi
}

# Run setup
setup_ruby_env

# Build and serve the site with live reload
echo "Starting Jekyll server..."
bundle exec jekyll serve --livereload --incremental

# Note: If you encounter any issues, try running these commands manually:
# bundle install     # Install dependencies
# bundle update      # Update dependencies 