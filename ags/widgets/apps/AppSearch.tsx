import { Gtk } from 'ags/gtk4';
import AstalApps from 'gi://AstalApps';

interface Props {
    list: AstalApps.Application[];
}

function AppSearch({ list }: Props) {
    return (
        <scrolledwindow propagateNaturalWidth name="app-search">
            <Gtk.ListBox
                selectionMode={Gtk.SelectionMode.NONE}
                class="boxed-list"
            >
                {list.map(app => (
                    <button
                        class="flat"
                        tooltipText={app.description}
                        onClicked={() => app.launch()}
                    >
                        <box class="horizontal" spacing={4}>
                            <image
                                iconName={app.iconName}
                                iconSize={Gtk.IconSize.LARGE}
                            />
                            <label label={app.name} />
                        </box>
                    </button>
                ))}
            </Gtk.ListBox>
        </scrolledwindow>
    );
}

export default AppSearch;
