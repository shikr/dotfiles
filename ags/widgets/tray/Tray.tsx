import { createState, With } from 'ags';
import { Gtk } from 'ags/gtk4';
import AstalTray from 'gi://AstalTray';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import TrayItem from './TrayItem';

interface Dimension {
    width: number;
    height: number;
}

const optimalDimension = (size: number) => {
    const result: Dimension = {
        height: 0,
        width: 0,
    };
    let minDiff = size;

    for (let h = 1; h <= Math.sqrt(size); h++) {
        if (size % h == 0) {
            const w = Math.floor(size / h);
            if (w >= h) {
                const diff = w - h;
                if (diff < minDiff) {
                    result.width = w;
                    result.height = h;
                    minDiff = diff;
                }
            }
        }
    }

    return result;
};

const ICONS = {
    open: 'pan-up-symbolic',
    close: 'pan-down-symbolic',
};

function Tray() {
    const tray = AstalTray.get_default();
    const [items, setItems] = createState(tray.items);
    const [icon, setIcon] = createState(ICONS.close);

    tray.connect('item-added', source => setItems(source.items));

    tray.connect('item-removed', source => setItems(source.items));

    return (
        <BarButton iconName={icon}>
            <BarPopover
                onMap={() => setIcon(ICONS.open)}
                onUnmap={() => setIcon(ICONS.close)}
            >
                <With value={items}>
                    {items => {
                        const dimension = optimalDimension(items.length);
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
