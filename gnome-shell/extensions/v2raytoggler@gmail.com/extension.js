/* extension.js
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

/* exported init */

const GETTEXT_DOMAIN = 'my-indicator-extension';

const { GObject, St } = imports.gi;
const Gio = imports.gi.Gio;
const GLib = imports.gi.GLib;
const ExtensionUtils = imports.misc.extensionUtils;
const Main = imports.ui.main;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;


function readFileContents(filePath) {
        // Read the content of the file synchronously
        let [success, content] = GLib.file_get_contents(filePath);

        if (success) {
            // If successful, 'content' now contains the file content as a string
            return content.toString();
        } else {
            logError("Failed to read file contents");
            return 0;
        }
}

function changeIcon(icon) {
    GLib.timeout_add(GLib.PRIORITY_DEFAULT, 3000, function () {
        let v2ray_status = parseInt(readFileContents(homeDir + "/.v2raystatus"));
        let warp_status = parseInt(readFileContents(homeDir + "/.warp_status"));
        if (warp_status == 1 && v2ray_status == 1) {
            icon.icon_name = "emblem-default";
            //Main.notify(_("Both"));
        }
        else if (warp_status == 1 && v2ray_status == 0) {
            icon.icon_name = "emblem-readonly";
            //Main.notify(_("Warp"));
        }
        else if (warp_status == 0 && v2ray_status == 1) {
            icon.icon_name = "emblem-symbolic-link";
            //Main.notify(_("V2ray"));
        }
        else if (warp_status == 0 && v2ray_status == 0) {
            icon.icon_name = "emblem-new";
            //Main.notify(_("None"));
        }
        // Returning false indicates that the timeout should not be repeated
        return true;
      });    
}





const homeDir = GLib.get_home_dir();


const _ = ExtensionUtils.gettext;

let icon = new St.Icon({
    icon_name: 'security-medium-symbolic',
    style_class: 'system-status-icon',
});

const Indicator = GObject.registerClass(
    class Indicator extends PanelMenu.Button {
        _init() {
            super._init(0.0, _('My Shiny Indicator'));

            this.add_child(icon);
            changeIcon(icon);
            
            // Warp Toggle
            let warp = new PopupMenu.PopupMenuItem(_('Toggle Warp'));
            warp.connect('activate', () => {
                let proc = Gio.Subprocess.new(['toggle_warp'], Gio.SubprocessFlags.STDOUT_PIPE | Gio.SubprocessFlags.STDERR_PIPE);
            });
            this.menu.addMenuItem(warp);

            // V2ray Toggle
            let v2ray = new PopupMenu.PopupMenuItem(_('Toggle V2ray'));
            v2ray.connect('activate', () => {
                let proc = Gio.Subprocess.new(['toggle_v2ray'], Gio.SubprocessFlags.STDOUT_PIPE | Gio.SubprocessFlags.STDERR_PIPE);
            });
            this.menu.addMenuItem(v2ray);

        }
    });

class Extension {
    constructor(uuid) {
        this._uuid = uuid;

        ExtensionUtils.initTranslations(GETTEXT_DOMAIN);
    }

    enable() {
        this._indicator = new Indicator();
        Main.panel.addToStatusArea(this._uuid, this._indicator);
    }

    disable() {
        this._indicator.destroy();
        this._indicator = null;
    }
}

function init(meta) {
    return new Extension(meta.uuid);
}
