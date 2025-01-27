#!/bin/bash

# Step 1: Find the Firefox profile directory
PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name '*default-release' | head -n 1)

if [ -z "$PROFILE_DIR" ]; then
  echo "Firefox profile directory not found!"
  exit 1
fi

echo "Firefox profile directory found: $PROFILE_DIR"

# Step 2: Create the chrome directory if it doesn't exist
CHROME_DIR="$PROFILE_DIR/chrome"
if [ ! -d "$CHROME_DIR" ]; then
  echo "Creating chrome directory..."
  mkdir -p "$CHROME_DIR"
fi

# Step 3: Create or update the userChrome.css file
USER_CHROME_FILE="$CHROME_DIR/userChrome.css"
echo "Creating/updating userChrome.css..."

cat <<EOL > "$USER_CHROME_FILE"
/* hides the native tabs */
#TabsToolbar {
  visibility: collapse !important;
}
/* hides the title bar */
#titlebar {
  visibility: collapse !important;
}
/* leaves space for the window buttons */
/* #nav-bar {
     margin-top: -8px;
     margin-right: 74px;
     margin-bottom: -4px;
 }
*/
EOL

echo "userChrome.css has been created/updated at: $USER_CHROME_FILE"

# Step 4: Enable custom CSS in Firefox
echo "Enabling custom CSS in Firefox..."
about_config_file="$PROFILE_DIR/prefs.js"
if ! grep -q "toolkit.legacyUserProfileCustomizations.stylesheets" "$about_config_file"; then
  echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$about_config_file"
fi

echo "Done! Please restart Firefox for changes to take effect."
