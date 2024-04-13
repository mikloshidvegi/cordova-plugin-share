package hu.rudaskarig.gispan;

import androidx.core.R;

public class FileProvider extends androidx.core.content.FileProvider {
	public FileProvider() {
		super(R.xml.file_paths);
	}
}
