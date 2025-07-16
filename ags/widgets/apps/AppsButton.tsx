import { execAsync } from 'ags/process';

function AppsButton() {
    return (
        <button
            onClicked={() => execAsync('echo hello').then(console.log)}
            cssClasses={['raised', 'image-button']}
            iconName="start-here-symbolic"
        />
    );
}

export default AppsButton;
