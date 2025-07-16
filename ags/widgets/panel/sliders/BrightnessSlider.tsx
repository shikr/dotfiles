import { createBinding, With } from 'ags';
import { Brightness } from '../../../utils/brightness';
import Slider from './widgets/Slider';

function BrightnessSlider() {
    const brightness = Brightness.get_default();
    const value = createBinding(brightness, 'brightness');

    return (
        <With value={createBinding(brightness, 'isAvailable')}>
            {(available: boolean) =>
                available && (
                    <Slider
                        startWidget={
                            <image
                                iconName={createBinding(brightness, 'iconName')}
                            />
                        }
                        min={0}
                        max={brightness.maxBrightness}
                        value={value}
                        label={value(
                            v => (v / brightness.maxBrightness) * 100 + '%'
                        )}
                        updateValue={v =>
                            brightness.set_property('brightness', v)
                        }
                    />
                )
            }
        </With>
    );
}

export default BrightnessSlider;
