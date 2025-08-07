#!/bin/bash

# Exit script if any command fails
set -e

echo "Installing Jekyll development environment..."

# Set up Ruby environment safely (without sudo)
setup_ruby_env() {
  # Check if Homebrew is installed
  if command -v brew &> /dev/null; then
    echo "Setting up Ruby environment using Homebrew..."

    # Check if Ruby is installed via Homebrew
    if ! brew list ruby &> /dev/null; then
      echo "Installing Ruby via Homebrew..."
      brew install ruby
    else
      echo "Ruby already installed via Homebrew"
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
    exit 1
  fi

  # Remove existing bundler installation
  echo "Removing existing bundler installation..."
  gem uninstall bundler --all --executables || true

  # Install bundler if needed - specify version to match Gemfile.lock
  if [ -f "Gemfile.lock" ]; then
    BUNDLER_VERSION=$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1 | tr -d ' ')
    if [[ -n "$BUNDLER_VERSION" ]]; then
      echo "Installing Bundler version $BUNDLER_VERSION to match Gemfile.lock..."
      gem install bundler:$BUNDLER_VERSION --install-dir "$GEM_HOME"
    else
      echo "Installing latest Bundler..."
      gem install bundler --install-dir "$GEM_HOME"
    fi
  else
    echo "No Gemfile.lock found, installing latest Bundler..."
    gem install bundler --install-dir "$GEM_HOME"
  fi

  # Ensure bundler is in PATH
  export PATH="$GEM_HOME/bin:$PATH"

  # Verify bundler is properly installed
  echo "Bundler version: $(bundle -v)"

  # Install Jekyll dependencies locally
  echo "Installing Jekyll dependencies locally..."
  bundle config set --local path 'vendor/bundle'
  bundle install

  echo "Dependencies installed successfully in vendor/bundle"
}

# Download and setup theme for offline use
setup_theme_for_offline() {
  echo "Setting up theme for offline use..."

  # Create themes directory
  mkdir -p .jekyll-cache/themes

  # Check if we have network connectivity
  if ping -c 1 github.com &> /dev/null; then
    echo "Network available - downloading remote theme..."

    # Download the theme using bundle
    echo "Caching remote theme files..."
    bundle exec jekyll build --dry-run || true

    # Force Jekyll to download the remote theme
    if [ ! -d ".jekyll-cache/themes/no-style-please" ]; then
      echo "Manually downloading theme for offline use..."
      git clone https://github.com/riggraz/no-style-please.git .jekyll-cache/themes/no-style-please-repo

      # Extract theme files to cache location
      mkdir -p .jekyll-cache/themes/no-style-please
      cp -r .jekyll-cache/themes/no-style-please-repo/* .jekyll-cache/themes/no-style-please/
      rm -rf .jekyll-cache/themes/no-style-please-repo
      rm -rf .jekyll-cache/themes/no-style-please/.git
    fi

    echo "Theme cached successfully for offline use"
  else
    echo "No network connection - skipping theme download"
    echo "Theme will be downloaded on first online run"
  fi

  # Create a backup configuration for offline mode
  echo "Creating offline configuration..."

  # Create offline config that disables remote theme plugin
  cat > _config_offline.yml << 'EOF'
# Offline configuration - bypasses remote theme downloads

# Site settings
title: LNSY
email: lindsey.mysse@gmail.com
description: I am a Multi-Webby winning web designer and developer who has also worked in environmental design, interface and fine art. I have developed software solutions for everything from gestural interface for musical instruments to tech platforms for open source intelligence. Over the past 7 years I've developed interfaces for machine learning applications, incorporating both new and mature technology back-ends.
baseurl: ""
url: "https://lnsy-dev.github.io"
github_username: lnsy-dev

# Build settings - use local theme instead of remote
theme: no-style-please
plugins:
  - jekyll-feed
  # jekyll-remote-theme is disabled for offline mode

# Add custom includes
include:
  - _includes/head.html

# Add custom head
head_custom: |
  <link rel="stylesheet" href="/assets/custom.css">

# Markdown settings
markdown_ext: "md"

# Collections
collections:
  tags:
    output: true
    permalink: /tags/:path/

# Collection defaults
defaults:
  - scope:
      path: ""
      type: tags
    values:
      layout: tag
EOF
}

# Create environment setup file for start.sh to source
create_env_file() {
  echo "Creating environment configuration file..."
  cat > .jekyll_env << EOF
# Jekyll environment configuration
# This file is sourced by start.sh to set up the Ruby environment

export GEM_HOME="$HOME/.gem"
export GEM_PATH="$GEM_HOME:/opt/homebrew/lib/ruby/gems/3.4.0"
export PATH="/opt/homebrew/opt/ruby/bin:$GEM_HOME/bin:$PATH"
EOF
  echo "Environment configuration saved to .jekyll_env"
}

# Ensure 404 page exists
ensure_404_exists() {
  if [ ! -f "404.html" ]; then
    echo "Creating a basic 404.html file..."
    cat > 404.html << 'EOF'
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
    echo "Created 404.html"
  else
    echo "404.html already exists"
  fi
}

# Create initial site build to cache everything
initial_build() {
  echo "Performing initial build to cache all assets..."

  # Source the environment
  source .jekyll_env

  # Try to build with network first (for remote theme)
  if ping -c 1 github.com &> /dev/null; then
    echo "Building with remote theme (online)..."
    bundle exec jekyll build --config _config.yml || {
      echo "Online build failed, will use offline mode"
      bundle exec jekyll build --config _config_offline.yml
    }
  else
    echo "Building with offline configuration..."
    bundle exec jekyll build --config _config_offline.yml
  fi

  echo "Initial build completed"
}

# Run installation
echo "Starting Jekyll installation process..."
setup_ruby_env
setup_theme_for_offline
create_env_file
ensure_404_exists
initial_build

echo ""
echo "✅ Installation complete!"
echo ""
echo "Theme and dependencies have been cached for offline use."
echo "You can now run './start.sh' to start the Jekyll development server."
echo "The server will automatically use offline mode when no network is available."
echo ""
echo "To update dependencies or theme, re-run this install script while online."
