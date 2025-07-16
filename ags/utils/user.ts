import GLib from 'gi://GLib';

export function getPicture() {
    const path = GLib.build_filenamev([GLib.get_home_dir(), '.face']);
    if (GLib.file_test(path, GLib.FileTest.EXISTS)) return path;

    return null;
}

export function getDisplayName() {
    const user = GLib.get_user_name();
    const realName = GLib.get_real_name();

    return realName || user;
}
