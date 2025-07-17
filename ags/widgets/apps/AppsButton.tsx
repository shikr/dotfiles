import { Gtk } from 'ags/gtk4';
import Gio from 'gi://Gio';
import { getDisplayName, getPicture } from '../../utils/user';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import Apps from './Apps';

function AppsButton() {
    const picture = getPicture();
    const displayName = getDisplayName();
    const image =
        picture === null
            ? Gtk.Image.new_from_icon_name('user-info-symbolic')
            : Gtk.Image.new_from_file(picture);

    const menu = Gio.Menu.new();
    menu.append('Shutdown', 'app.shutdown');
    menu.append('Reboot', 'app.reboot');

    return (
        <BarButton iconName="start-here-symbolic">
            <BarPopover>
                <box
                    orientation={Gtk.Orientation.VERTICAL}
                    class="vertical"
                    spacing={6}
                >
                    <Apps />
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
