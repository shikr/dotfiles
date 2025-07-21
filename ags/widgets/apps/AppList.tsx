import { Gtk } from 'ags/gtk4';
import AstalApps from 'gi://AstalApps';

// Defined in https://specifications.freedesktop.org/menu-spec/latest/category-registry.html
const COMMON_CATEGORIES = {
    AudioVideo: 'multimedia',
    Audio: 'multimedia',
    Video: 'multimedia',
    Development: 'development',
    Education: 'education',
    Game: 'games',
    Graphics: 'graphics',
    Network: 'internet',
    Office: 'office',
    Science: 'science',
    Settings: 'system',
    System: 'system',
    Utility: 'utilities',

    Other: 'other',
};

interface Props {
    list: AstalApps.Application[];
    hide: () => unknown;
}

function AppList({ list, hide }: Props) {
    // TODO: Use Object.groupBy when available in tsserver
    const items = list.reduce<Record<string, AstalApps.Application[]>>(
        (acc, app) => ({
            ...acc,
            ...Object.fromEntries(
                app.categories
                    .filter(x => x in COMMON_CATEGORIES)
                    .map(category => [
                        category,
                        [...(acc[category] ?? []), app],
                    ])
            ),
        }),
        {}
    );
    const other = list.filter(app =>
        app.categories.every(cat => !(cat in COMMON_CATEGORIES))
    );

    if (other.length > 0) {
        items['Other'] = other;
    }

    const notebook = new Gtk.Notebook({
        tabPos: Gtk.PositionType.LEFT,
        name: 'app-list',
    });

    for (const item in items) {
        const listBox = new Gtk.ListBox({
            selectionMode: Gtk.SelectionMode.NONE,
            cssClasses: ['boxed-list'],
            activateOnSingleClick: true,
        });

        // FIXME: Terminal applications should open in a terminal
        listBox.connect(
            'row-activated',
            (_, row) => (hide(), items[item][row.get_index()].launch())
        );

        items[item].forEach(app =>
            listBox.append(
                (
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
                ) as Gtk.Widget
            )
        );

        notebook.append_page(
            (
                <scrolledwindow propagateNaturalWidth>{listBox}</scrolledwindow>
            ) as Gtk.Widget,
            (
                <box class="horizontal" spacing={4}>
                    <image
                        iconName={`applications-${
                            COMMON_CATEGORIES[
                                item as keyof typeof COMMON_CATEGORIES
                            ]
                        }-symbolic`}
                    />
                    <label halign={Gtk.Align.START} label={item} />
                </box>
            ) as Gtk.Widget
        );
    }

    return notebook;
}

export default AppList;
