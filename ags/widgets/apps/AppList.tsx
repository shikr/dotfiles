import { Gtk } from 'ags/gtk4';
import AstalApps from 'gi://AstalApps';

// Defined in https://specifications.freedesktop.org/menu-spec/latest/category-registry.html
const COMMON_CATEGORIES = {
    Utility: 'utilities',
    Development: 'development',
    Education: 'education',
    Game: 'games',
    Graphics: 'graphics',
    AudioVideo: 'multimedia',
    Network: 'internet',
    Office: 'office',
    Settings: 'system',
    Science: 'science',
    System: 'system',

    Other: 'other',
};

const CATEGORY_OVERRIDE = {
    Utility: 'Accessories',
    Game: 'Games',
    AudioVideo: 'Multimedia',
    Settings: 'Preferences',
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
                    .map(category => [category, [...acc[category], app]])
            ),
        }),
        Object.fromEntries(
            Object.entries(COMMON_CATEGORIES).map(([category]) => [
                category,
                [],
            ])
        )
    );
    items['Other'] = list.filter(app =>
        app.categories.every(cat => !(cat in COMMON_CATEGORIES))
    );

    const notebook = new Gtk.Notebook({
        tabPos: Gtk.PositionType.LEFT,
        name: 'app-list',
    });

    for (const item in items) {
        if (items[item].length === 0) continue;

        const listBox = new Gtk.ListBox({
            selectionMode: Gtk.SelectionMode.NONE,
            activateOnSingleClick: true,
            showSeparators: true,
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
                    <label
                        halign={Gtk.Align.START}
                        label={
                            item in CATEGORY_OVERRIDE
                                ? CATEGORY_OVERRIDE[
                                      item as keyof typeof CATEGORY_OVERRIDE
                                  ]
                                : item
                        }
                    />
                </box>
            ) as Gtk.Widget
        );
    }

    return notebook;
}

export default AppList;
