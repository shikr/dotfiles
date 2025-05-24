wallpapers="$HOME/.local/share/wallpapers"
wallpaper="$wallpapers/wall-niri"
overview="$wallpapers/wall-overview"
overview_config="$HOME/.config/niri-overview"

src="$1"

if [ -z "$src" ]; then
  backgrounds="$HOME/.local/share/backgrounds"
  mkdir -p $backgrounds
  src=$(yad --file --workdir=$backgrounds --title "Wallpaper Selector" --file-filter="Images | *.jpg *.png *.jpeg *.webp" --add-preview --large-preview)
  if [ -z "$src" ]; then
    echo "No wallpaper selected."
    exit 1
  fi
fi

ext="${src##*.}"

wall_output="$wallpaper.$ext"
view_output="$overview.$ext"

remove_exists() {
  if [ -f $1 ]; then
    rm $1
  fi
}

mkdir -p $wallpapers

remove_exists $wall_output
remove_exists $view_output

cp $src $wall_output
ffmpeg -i $src -vf "gblur=sigma=10" $view_output

# Save current swaybg image
echo $view_output > $overview_config

swww img --transition-type wipe --transition-angle 30 --transition-fps 60 $wall_output
systemctl --user restart swaybg.service
