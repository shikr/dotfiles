import { Settings } from '../../utils/settings';

function BarPopover({ $, ...props }: JSX.IntrinsicElements['popover']) {
    const settings = Settings.get_default();

    return (
        <popover
            $={(...args) => {
                const [self] = args;
                const setOffset = () =>
                    settings.position === 'top'
                        ? self.set_offset(0, 10)
                        : self.set_offset(0, -10);

                setOffset();
                settings.connect('notify::position', setOffset);

                if ($) return $(...args);
            }}
            hasArrow={false}
            {...props}
        />
    );
}

export default BarPopover;
