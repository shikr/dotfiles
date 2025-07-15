import { Gtk } from 'ags/gtk4';
import BluetoothButton from '../BluetoothButton';
import DndButton from '../DndButton';
import WifiButton from '../WifiButton';
import { ButtonProps } from './ButtonProps';

function ButtonBox() {
    const group = Gtk.SizeGroup.new(Gtk.SizeGroupMode.HORIZONTAL);

    const setup: ButtonProps['setup'] = widget => group.add_widget(widget);

    return (
        <box class="horizontal" spacing={4}>
            <WifiButton setup={setup} />
            <BluetoothButton setup={setup} />
            <DndButton setup={setup} />
        </box>
    );
}

export default ButtonBox;
