import { createContext } from 'ags';
import { Gdk } from 'ags/gtk4';

const MonitorContext = createContext(new Gdk.Monitor());

export default MonitorContext;
