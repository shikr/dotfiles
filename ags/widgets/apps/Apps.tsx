import { createBinding, createState, With } from 'ags';
import AstalApps from 'gi://AstalApps';
import AppList from './AppList';
import AppSearch from './AppSearch';

interface Props {
    hide: () => unknown;
}

function Apps({ hide }: Props) {
    const apps = AstalApps.Apps.new();
    const [query, setQuery] = createState('');

    return (
        <>
            <entry
                text={query}
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
                        <AppList $type="named" hide={hide} list={list} />
                    )}
                </With>
                <With value={query}>
                    {query => (
                        <AppSearch
                            $type="named"
                            reset={() => (hide(), setQuery(''))}
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
