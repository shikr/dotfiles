import { createBinding, With } from 'ags';
import AstalApps from 'gi://AstalApps';
import AppList from './AppList';

function Apps() {
    const apps = AstalApps.Apps.new();

    return (
        <With value={createBinding(apps, 'list')}>
            {(list: AstalApps.Application[]) => <AppList list={list} />}
        </With>
    );
}

export default Apps;
