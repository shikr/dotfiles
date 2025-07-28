import { createState } from 'ags';
import AccountsService from 'gi://AccountsService';
import GLib from 'gi://GLib';
import Avatar from './Avatar';

function UserInfo() {
    const username = GLib.get_user_name();
    const userManager = AccountsService.UserManager.get_default();
    // Load all users
    userManager.list_users();
    const user = userManager.get_user(username);
    const [displayName, setDisplayName] = createState(
        user.realName || username
    );

    user.connect('changed', () =>
        setDisplayName(user.realName || user.userName)
    );

    return (
        <button class="flat">
            <box class="horizontal" spacing={6}>
                <Avatar user={user} displayName={displayName} />
                <label class="body" label={displayName} />
            </box>
        </button>
    );
}

export default UserInfo;
