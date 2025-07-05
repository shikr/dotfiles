import { Gtk } from 'ags/gtk4';
import Gio from 'gi://Gio';
import GLib from 'gi://GLib';

export function getIconTheme() {
    const gsettings = Gio.Settings.new('org.gnome.desktop.interface');
    const theme = gsettings.get_string('icon-theme');
    if (theme)
        return new Gtk.IconTheme({
            themeName: theme,
        });
    return new Gtk.IconTheme();
}

export function isIcon(iconName: string) {
    const theme = getIconTheme();
    return theme.has_icon(iconName);
}

export function getIconType(iconName: string): 'file' | 'icon' | null {
    if (isIcon(iconName)) return 'icon';
    if (GLib.file_test(iconName, GLib.FileTest.IS_REGULAR)) return 'file';
    return null;
}
