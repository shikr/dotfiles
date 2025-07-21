import { Gtk } from 'ags/gtk4';
import AstalApps from 'gi://AstalApps';

interface Props {
    list: AstalApps.Application[];
    reset: () => unknown;
}

function AppSearch({ list, reset }: Props) {
    return (
        <scrolledwindow propagateNaturalWidth name="app-search">
            <Gtk.ListBox
                onRowActivated={(_, row) => (
                    reset(), list[row.get_index()].launch()
                )}
                selectionMode={Gtk.SelectionMode.NONE}
                class="boxed-list"
            >
                {list.map(app => (
                    <box
                        class="horizontal"
                        spacing={4}
                        tooltipText={app.description}
                    >
                        <image
                            iconName={app.iconName}
                            iconSize={Gtk.IconSize.LARGE}
                        />
                        <label label={app.name} />
                    </box>
                ))}
            </Gtk.ListBox>
        </scrolledwindow>
    );
}

export default AppSearch;
