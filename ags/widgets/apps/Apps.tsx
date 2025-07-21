import { createBinding, createState, With } from 'ags';
import AstalApps from 'gi://AstalApps';
import AppList from './AppList';
import AppSearch from './AppSearch';

function Apps() {
    const apps = AstalApps.Apps.new();
    const [query, setQuery] = createState('');

    return (
        <>
            <entry
                placeholderText="Search"
                primaryIconName="system-search-symbolic"
                onNotifyText={source => setQuery(source.text)}
            />
            <stack
                $={self =>
                    query.subscribe(
                        () =>
                            (self.visibleChildName =
                                query.get().length > 0
                                    ? 'app-search'
                                    : 'app-list')
                    )
                }
            >
                <With value={createBinding(apps, 'list')}>
                    {(list: AstalApps.Application[]) => (
                        <AppList $type="named" list={list} />
                    )}
                </With>
                <With value={query}>
                    {query => (
                        <AppSearch
                            $type="named"
                            list={
                                query.length > 0 ? apps.fuzzy_query(query) : []
                            }
                        />
                    )}
                </With>
            </stack>
        </>
    );
}

export default Apps;
