import { Gtk } from 'ags/gtk4';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import Clock from '../clock/Clock';
import PanelButton from '../panel/PanelButton';
import Tray from '../tray/Tray';

function Right() {
    return (
        <box $type="end" class="horizontal" halign={Gtk.Align.END} spacing={4}>
            <Tray />
            <PanelButton />
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
