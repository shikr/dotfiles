import { Gtk } from 'ags/gtk4';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import Clock from '../clock/Clock';
import Battery from '../status/Battery';
import Network from '../status/Network';
import Speaker from '../status/Speaker';
import Tray from '../tray/Tray';

function Right() {
    return (
        <box $type="end" class="horizontal" halign={Gtk.Align.END} spacing={4}>
            <Tray />
            <button class="raised">
                <box spacing={6} class="horizontal">
                    <Network />
                    <Speaker />
                    <Battery />
                </box>
            </button>
            <BarButton>
                <Clock />
                <BarPopover>
                    <box
                        orientation={Gtk.Orientation.VERTICAL}
                        class="vertical"
                    >
                        <Gtk.Calendar />
                    </box>
                </BarPopover>
            </BarButton>
        </box>
    );
}

export default Right;
