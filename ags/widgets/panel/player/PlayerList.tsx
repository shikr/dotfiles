import { createState, getScope } from 'ags';
import { Gtk } from 'ags/gtk4';
import AstalMpris from 'gi://AstalMpris';
import Player from './Player';

function PlayerList() {
    const mpris = AstalMpris.get_default();
    const [players, setPlayers] = createState(mpris.get_players());
    const scope = getScope();

    return (
        <Gtk.ListBox
            $={self => {
                scope.run(() =>
                    players
                        .get()
                        .forEach((player, i) =>
                            self.insert(
                                (<Player player={player} />) as Gtk.Widget,
                                i
                            )
                        )
                );

                mpris.connect('player-added', (_, player) =>
                    scope.run(() => {
                        self.insert(
                            (<Player player={player} />) as Gtk.Widget,
                            players.get().length
                        );
                        setPlayers(pys => [...pys, player]);
                    })
                );

                mpris.connect('player-closed', (_, player) =>
                    scope.run(() => {
                        const index = players.get().indexOf(player);
                        const widget = self.get_row_at_index(index);

                        if (widget !== null) self.remove(widget);
                        setPlayers(pys => pys.filter((_, i) => i !== index));
                    })
                );
            }}
            class="boxed-list-separate"
            selectionMode={Gtk.SelectionMode.NONE}
        />
    );
}

export default PlayerList;
