package cordova.plugin.share;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.net.Uri;

    /**
     * This class echoes a string called from JavaScript.
     */
    public class Share extends CordovaPlugin {

        @Override
        public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
            if (action.equals("share")) {
                String text = args.getString(0);
                String title = args.getString(1);
                String mimetype = args.getString(2);
                this.share(text, title, mimetype, callbackContext);
                return true;
            }
            return false;
        }

        private void share(String text, String title, String mimetype, CallbackContext callbackContext) {
          try {
            Intent sendIntent = new Intent();
            sendIntent.setAction(Intent.ACTION_SEND);
            if (mimetype.equals("text/plain")) {
                sendIntent.putExtra(Intent.EXTRA_TEXT, text);
            } else {
                sendIntent.putExtra(Intent.EXTRA_STREAM, Uri.parse(text));
            }
            sendIntent.setType(mimetype);
            cordova.getActivity().startActivity(Intent.createChooser(sendIntent, title));
            callbackContext.success();
            } catch(Error e) {
                callbackContext.error(e.getMessage());
            }

        }
    }