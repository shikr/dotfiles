import { createBinding } from 'ags';
import { Gdk, Gtk } from 'ags/gtk4';
import AstalTray from 'gi://AstalTray';

interface Props {
    item: AstalTray.TrayItem;
}

function TrayItem({ item }: Props) {
    const popover = new Gtk.PopoverMenu({ menu_model: item.menuModel });

    popover.insert_action_group('dbusmenu', item.actionGroup);

    return (
        <button
            $={self => {
                const gesture = Gtk.GestureClick.new();

                gesture.set_button(Gdk.BUTTON_SECONDARY);

                gesture.connect('pressed', () => popover.popup());

                self.add_controller(gesture);
                popover.set_parent(self);
            }}
            cssClasses={['flat', 'image-button']}
            tooltipMarkup={createBinding(item, 'tooltipMarkup')}
            onClicked={() => item.activate(0, 0)}
        >
            <image gicon={createBinding(item, 'gicon')} />
        </button>
    );
}

export default TrayItem;
