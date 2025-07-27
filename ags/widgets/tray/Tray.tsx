import { createBinding, createComputed, createState, With } from 'ags';
import { Gtk } from 'ags/gtk4';
import AstalTray from 'gi://AstalTray';
import { optimalGeometry } from '../../utils/grid';
import { Settings } from '../../utils/settings';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import TrayItem from './TrayItem';

function Tray() {
    const tray = AstalTray.get_default();
    const settings = Settings.get_default();
    const [items, setItems] = createState(tray.items);
    const [opened, setOpened] = createState(false);
    const direction = createComputed(
        [opened, createBinding(settings, 'position')],
        (opened, position) => {
            if (opened)
                return position === 'top'
                    ? Gtk.ArrowType.UP
                    : Gtk.ArrowType.DOWN;
            return position === 'top' ? Gtk.ArrowType.DOWN : Gtk.ArrowType.UP;
        }
    );

    tray.connect('item-added', source => setItems(source.items));

    tray.connect('item-removed', source => setItems(source.items));

    return (
        <BarButton direction={direction}>
            <BarPopover
                onMap={() => setOpened(true)}
                onUnmap={() => setOpened(false)}
            >
                <With value={items}>
                    {items => {
                        const dimension = optimalGeometry(items.length);
                        const items_ = items
                            .filter(
                                item => item.status !== AstalTray.Status.PASSIVE
                            )
                            .reduce<AstalTray.TrayItem[][]>((acc, value, i) => {
                                const row = Math.floor(i / dimension.width);
                                const col = i % dimension.width;
                                if (col == 0) acc[row] = [];
                                acc[row][col] = value;
                                return acc;
                            }, []);

                        return (
                            <box
                                orientation={Gtk.Orientation.VERTICAL}
                                class="vertical"
                            >
                                {items_.map(row => (
                                    <box class="horizontal">
                                        {row.map(item => (
                                            <TrayItem item={item} />
                                        ))}
                                    </box>
                                ))}
                            </box>
                        );
                    }}
                </With>
            </BarPopover>
        </BarButton>
    );
}

export default Tray;
