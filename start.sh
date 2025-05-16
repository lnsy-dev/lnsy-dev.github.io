#!/bin/bash

# Exit script if any command fails
set -e

echo "Starting Jekyll development server with live reload..."

# Kill any existing Jekyll processes
kill_existing_processes() {
  echo "Checking for existing Jekyll processes..."
  if ps aux | grep "[j]ekyll serve" > /dev/null; then
    echo "Killing existing Jekyll processes..."
    pkill -f "jekyll serve" || true
  fi
}

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
    
    # Set up gem paths
    export GEM_HOME="$HOME/.gem"
    export GEM_PATH="$GEM_HOME:/opt/homebrew/lib/ruby/gems/3.4.0"
    export PATH="/opt/homebrew/opt/ruby/bin:$GEM_HOME/bin:$PATH"
    
    # Check Ruby version to confirm we're using Homebrew Ruby
    RUBY_VERSION=$(ruby -v)
    echo "Using Ruby: $RUBY_VERSION"
    echo "Ruby path: $(which ruby)"
    echo "Gem path: $(which gem)"
  else
    echo "Homebrew not found. Installing Ruby environment may require sudo permissions."
    echo "Consider installing Homebrew (https://brew.sh/) for a safer Ruby setup."
  fi
  
  # Remove existing bundler installation
  echo "Removing existing bundler installation..."
  gem uninstall bundler --all --executables || true
  
  # Install bundler if needed - specify version to match Gemfile.lock
  BUNDLER_VERSION=$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1 | tr -d ' ')
  if [[ -n "$BUNDLER_VERSION" ]]; then
    echo "Installing Bundler version $BUNDLER_VERSION to match Gemfile.lock..."
    gem install bundler:$BUNDLER_VERSION --install-dir "$GEM_HOME"
  else
    echo "Installing latest Bundler..."
    gem install bundler --install-dir "$GEM_HOME"
  fi
  
  # Ensure bundler is in PATH
  export PATH="$GEM_HOME/bin:$PATH"
  
  # Verify bundler is properly installed
  echo "Bundler version: $(bundle -v)"
  
  # Only install dependencies if vendor/bundle doesn't exist
  if [ ! -d "vendor/bundle" ]; then
    echo "Installing Jekyll dependencies locally..."
    bundle config set --local path 'vendor/bundle'
    bundle install
  else
    echo "Dependencies already installed in vendor/bundle"
  fi
}

# Clean previous build to ensure all content is fresh
clean_previous_build() {
  echo "Cleaning previous build artifacts..."
  if [ -d "_site" ]; then
    rm -rf _site
  fi
}

# Ensure 404 page exists
ensure_404_exists() {
  if [ ! -f "404.html" ]; then
    echo "Creating a basic 404.html file..."
    cat > 404.html << EOF
---
layout: default
permalink: /404.html
---

<style type="text/css" media="screen">
  .container {
    margin: 10px auto;
    max-width: 600px;
    text-align: center;
  }
  h1 {
    margin: 30px 0;
    font-size: 4em;
    line-height: 1;
    letter-spacing: -1px;
  }
</style>

<div class="container">
  <h1>404</h1>
  <p><strong>Page not found :(</strong></p>
  <p>The requested page could not be found.</p>
</div>
EOF
  fi
}

# Parse command line arguments
PORT="4000"  # Default port
while getopts "p:" opt; do
  case $opt in
    p) PORT="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

# Run setup
kill_existing_processes
setup_ruby_env
clean_previous_build
ensure_404_exists

# Build and serve the site with enhanced watching and reloading
echo "Starting Jekyll server with full site watching on port $PORT..."
bundle exec jekyll serve --port $PORT --livereload-port $((PORT + 1000)) --force_polling --watch --incremental

# Note: If you encounter any issues, try running these commands manually:
# bundle install     # Install dependencies
# bundle update      # Update dependencies 