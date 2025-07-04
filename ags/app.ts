import app from 'ags/gtk4/app';
import style from './style.scss';
import Bar from './widgets/Bar';
import NotificationWindow from './widgets/notification/NotificationWindow';

app.start({
    css: style,
    main() {
        [Bar, NotificationWindow].forEach(win =>
            app.get_monitors().forEach(m => win(m))
        );
    },
});
