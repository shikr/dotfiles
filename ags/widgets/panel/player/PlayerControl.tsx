import { createBinding } from 'ags';
import AstalMpris from 'gi://AstalMpris';

interface Props {
    player: AstalMpris.Player;
}

function PlayerControl({ player }: Props) {
    const iconName = createBinding(
        player,
        'playbackStatus'
    )(status =>
        status === AstalMpris.PlaybackStatus.PLAYING
            ? 'media-playback-pause-symbolic'
            : 'media-playback-start-symbolic'
    );

    return (
        <box class="horizontal" spacing={4}>
            <button
                class="image-button"
                sensitive={createBinding(player, 'canGoPrevious')}
                iconName="media-skip-backward-symbolic"
                onClicked={() => player.previous()}
            />
            <button
                class="image-button"
                sensitive={createBinding(player, 'canControl')}
                iconName={iconName}
                onClicked={() => player.play_pause()}
            />
            <button
                class="image-button"
                sensitive={createBinding(player, 'canGoNext')}
                iconName="media-skip-forward-symbolic"
                onClicked={() => player.next()}
            />
        </box>
    );
}

export default PlayerControl;
