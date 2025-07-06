import BatteryStatus from './status/BatteryStatus';
import NetworkStatus from './status/NetworkStatus';
import SpeakerStatus from './status/SpeakerStatus';

function PanelButton() {
    return (
        <button class="raised">
            <box spacing={6} class="horizontal">
                <NetworkStatus />
                <SpeakerStatus />
                <BatteryStatus />
            </box>
        </button>
    );
}

export default PanelButton;
