package hu.rudaskarig.gispan;

import android.R;

public class FileProvider extends androidx.core.content.FileProvider {
	public FileProvider() {
		super(R.xml.file_paths);
	}
}
