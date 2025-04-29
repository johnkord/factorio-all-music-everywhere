mod_name="$(jq '.name' all-music-everywhere/info.json | tr -d '"')"
mod_version="$(jq '.version' all-music-everywhere/info.json | tr -d '"')"

zip -r "${mod_name}_${mod_version}.zip" . \
  -x "*build.sh" \
  -x "*.git*" \
  -x "*.DS_Store" \
  -x "reference*"
