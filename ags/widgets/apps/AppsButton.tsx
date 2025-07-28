import { createBinding, With } from 'ags';
import { Gtk } from 'ags/gtk4';
import Gio from 'gi://Gio';
import { Settings } from '../../utils/settings';
import { getIconType } from '../../utils/theme';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import SettingsButton from '../settings/SettingsButton';
import UserInfo from '../user/UserInfo';
import Apps from './Apps';

// TODO: use AccountsService for icon/real name
function AppsButton() {
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
                        <box $type="start">
                            <UserInfo />
                        </box>
                        <box $type="center" />
                        <box $type="end" class="horizontal" spacing={6}>
                            <SettingsButton />
                            <menubutton
                                iconName="system-shutdown-symbolic"
                                cssClasses={['flat', 'image-button']}
                                menuModel={menu}
                            />
                        </box>
                    </centerbox>
                </box>
            </BarPopover>
        </BarButton>
    );
}

export default AppsButton;
