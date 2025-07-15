import { createBinding, createComputed, With } from 'ags';
import { Gtk } from 'ags/gtk4';
import Adw from 'gi://Adw';
import AstalMpris from 'gi://AstalMpris';
import Gio from 'gi://Gio';
import Pango from 'gi://Pango';
import EntryIcon from '../../common/EntryIcon';
import PlayerControl from './PlayerControl';

interface Props {
    player: AstalMpris.Player;
}

const formatSeconds = (secs: number) => {
    const minutes = Math.floor(secs / 60);
    const seconds = Math.floor(secs % 60);
    return `${minutes}:${String(seconds).padStart(2, '0')}`;
};

function Player({ player }: Props) {
    const title = createBinding(player, 'title');
    const position = createBinding(player, 'position');
    const length = createBinding(player, 'length');
    const progress = createComputed(
        [position, length],
        (position, length) =>
            `${formatSeconds(position)}/${formatSeconds(length)}`
    );
    const spacing = 4;

    return (
        <box
            orientation={Gtk.Orientation.VERTICAL}
            class="vertical"
            spacing={spacing}
            marginEnd={spacing}
            marginTop={spacing}
            marginStart={spacing}
            marginBottom={spacing}
        >
            <box class="horizontal" spacing={spacing}>
                <EntryIcon entry={player.entry} appName={player.identity} />
                <label label={player.identity} class="heading" />
            </box>
            <Gtk.Separator class="horizontal" />
            <box class="horizontal" spacing={spacing}>
                <box class="horizontal">
                    <With value={createBinding(player, 'coverArt')}>
                        {(coverArt: string) =>
                            Boolean(coverArt) && (
                                <Adw.Clamp
                                    maximumSize={64}
                                    orientation={Gtk.Orientation.VERTICAL}
                                >
                                    <Gtk.Picture
                                        file={Gio.File.new_for_path(coverArt)}
                                        contentFit={Gtk.ContentFit.COVER}
                                    />
                                </Adw.Clamp>
                            )
                        }
                    </With>
                </box>
                <box orientation={Gtk.Orientation.VERTICAL} class="vertical">
                    <label
                        wrap
                        class="title-4"
                        maxWidthChars={30}
                        halign={Gtk.Align.START}
                        label={title}
                        tooltipText={title}
                    />
                    <With value={createBinding(player, 'artist')}>
                        {(artist: string) =>
                            Boolean(artist) && (
                                <label
                                    class="body"
                                    label={artist}
                                    maxWidthChars={30}
                                    halign={Gtk.Align.START}
                                    ellipsize={Pango.EllipsizeMode.END}
                                    tooltipText={artist}
                                />
                            )
                        }
                    </With>
                </box>
            </box>
            <box cssClasses={['horizontal', 'osd', 'toolbar']}>
                <PlayerControl player={player} />
                <slider
                    hexpand
                    min={0}
                    max={length}
                    value={position}
                    widthRequest={150}
                    onChangeValue={slider =>
                        player.canSeek
                            ? player.set_position(slider.value)
                            : (() =>
                                  slider.value !== player.position
                                      ? slider.set_value(player.position)
                                      : void null)()
                    }
                />
                <label label={progress} halign={Gtk.Align.END} />
            </box>
        </box>
    );
}

export default Player;
