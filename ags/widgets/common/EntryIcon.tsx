import Gio from 'gi://Gio';
import { getIconType } from '../../utils/theme';

interface Props {
    entry?: string;
}

function EntryIcon({
    entry,
    ...props
}: Props & JSX.IntrinsicElements['image']) {
    if (!entry) return <></>;

    const icon =
        Gio.DesktopAppInfo.new_from_filename(entry)?.get_icon()?.to_string() ??
        undefined;
    if (icon === undefined) return <></>;

    const iconType = getIconType(icon);

    if (iconType === 'file') return <image file={icon} {...props} />;
    if (iconType === 'icon') return <image iconName={icon} {...props} />;

    return <></>;
}

export default EntryIcon;
