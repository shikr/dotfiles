import { createBinding, With } from 'ags';
import { Gtk } from 'ags/gtk4';
import Adw from 'gi://Adw';
import Gio from 'gi://Gio';
import { Settings } from '../../utils/settings';
import { getIconType } from '../../utils/theme';
import { getDisplayName, getPicture } from '../../utils/user';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import Apps from './Apps';

// TODO: use AccountsService for icon/real name
function AppsButton() {
    const picture = getPicture();
    const displayName = getDisplayName();
    const image = new Adw.Avatar({
        size: 24,
        text: displayName,
        showInitials: !Boolean(picture),
        iconName: 'avatar-default-symbolic',
    });
    if (picture !== null)
        image.set_custom_image(
            Gtk.IconPaintable.new_for_file(
                Gio.File.new_for_path(picture),
                24,
                1
            )
        );

    const menu = Gio.Menu.new();
    menu.append('Shutdown', 'app.shutdown');
    menu.append('Reboot', 'app.reboot');
    const settings = Settings.get_default();

    let popover: Gtk.Popover;

    const hide = () => popover.hide();

    return (
        <BarButton>
            <With value={createBinding(settings, 'icon')}>
                {(icon: string) => {
                    const iconType = getIconType(icon);

                    if (iconType === 'icon') return <image iconName={icon} />;
                    if (iconType === 'file') return <image file={icon} />;
                    return <image iconName="start-here-symbolic" />;
                }}
            </With>
            <BarPopover $={self => (popover = self)}>
                <box
                    orientation={Gtk.Orientation.VERTICAL}
                    class="vertical"
                    spacing={6}
                >
                    <Apps hide={hide} />
                    <centerbox class="horizontal">
                        <button $type="start" class="flat">
                            <box class="horizontal" spacing={6}>
                                {image}
                                <label class="body" label={displayName} />
                            </box>
                        </button>
                        <box $type="center" />
                        <menubutton
                            $type="end"
                            iconName="system-shutdown-symbolic"
                            cssClasses={['flat', 'image-button']}
                            menuModel={menu}
                        />
                    </centerbox>
                </box>
            </BarPopover>
        </BarButton>
    );
}

export default AppsButton;
