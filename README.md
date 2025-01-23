## OOP S3

### Anomalies in the build

#### Warning 1

```
Warning: SDK processing. This version only understands SDK XML versions up to 3 but an SDK XML file of version 4 was encountered. This can happen if you use versions of Android Studio and the command-line tools that were released at different times.
```

**Reason:**

1. **Outdated SDK Tools:** Your SDK tools might be outdated and do not support the newer XML version.
2. **Version Mismatch:** You might be using a newer version of Android Studio that generates SDK XML files of version 4, but your command-line tools are older and only understand up to version 3.

#### Warning 2

-   **Linux:**
    -   Default plugin: `file_picker:linux`
    -   **Solution:** Ask the maintainers to either avoid referencing a default implementation via `platforms: linux: default_package: file_picker` or add an inline implementation via `platforms: linux: pluginClass` or `dartPluginClass`.
-   **macOS:**
    -   Default plugin: `file_picker:macos`
    -   **Solution:** Ask the maintainers to either avoid referencing a default implementation via `platforms: macos: default_package: file_picker` or add an inline implementation via `platforms: macos: pluginClass` or `dartPluginClass`.
-   **Windows:**
    -   Default plugin: `file_picker:windows`
    -   **Solution:** Ask the maintainers to either avoid referencing a default implementation via `platforms: windows: default_package: file_picker` or add an inline implementation via `platforms: windows: pluginClass` or `dartPluginClass`.

##### Why is this Error of No Concern to Us

This issue is relevant for the Windows, Linux, and macOS platforms. However, it does not affect this project as it is focused solely on Android app development.

#### Warning 3

**Warning:**

```
[options] source value 8 is obsolete and will be removed in a future release
warning: [options] To suppress warnings about obsolete options, use -Xlint:-options.
```

**Reason:**

1. **Deprecated Java Version:** The project is using an outdated Java version (source value 8) which is no longer supported and will be removed in future releases.
2. **Target Compatibility:** The target value 8 is also obsolete and will be removed in future releases.
   **Solution:** To suppress warnings about obsolete options, use `-Xlint:-options` or update the project to use a supported Java version.



### Data Flow 
[![](https://mermaid.ink/img/pako:eNqNU8mS2jAQ_RWVTkkVTOEFz-BDqsBmCAcSwnKJzUGxG6OKLbkkOcX675E3PBQ5RKdWd7-n14suOOIxYBcnguQHtPFDhvQZB9u5i5b-O9rmKSfxDvX7X65LGv0unVc0CcrYGsQfGoGLpkclSKTQBo5qVzNMKsT3XNGMniGuQlfkBRtBmEyJopx1-NYJSHE0ZUlK5aHh8Sqee0JLNF7OjWB8LgTcwVy0hA20zPk32g9W4xmasxiO5YtLyiDirMX5FcjnUZEBU2ju95rUbySDK5oG3oFoN1Mg9iQC9KMAcUJLwSOQkrKkoZlWNFsJos6oRJtBiL1CKp6VN7QCTSzQJ0GSvrQQZ6J2RDz7HOKuDrPiWoHMOZOlho9NXkMKUVncO00BLUCRmChyRTM9RORTmafkVM2y1P8gbq1f0wApSaJJv9aFrSMBwFppTVRqXI2Uxa96V0Ks6T2eaUm6TTLEdbxS3JnTzpzVpuatjSe-roVoweMihQfSSWd6nel_IH0i1HsJgpG0bOGjwP9Yn7b1wdO8dk9v3kdUL0qzZSHDPZyByAiN9Re7lLkhVgfIIMSuNmPYkyJVpbKbTiWF4usTi7CrRAE9LHiRHLC7J6nUtyLXYwWfEl1d1qbkhP3k_H6FmOpCFvWXrn52lYLdCz5it29ZL0PTGtlDc-CYtmWZTg-ftH84ejFMxx4NnMHrqzN8G916-FzRGi-OYdvmyDAMy7HfbNO-_QVuNU3L?type=png)](https://mermaid.live/edit#pako:eNqNU8mS2jAQ_RWVTkkVTOEFz-BDqsBmCAcSwnKJzUGxG6OKLbkkOcX675E3PBQ5RKdWd7-n14suOOIxYBcnguQHtPFDhvQZB9u5i5b-O9rmKSfxDvX7X65LGv0unVc0CcrYGsQfGoGLpkclSKTQBo5qVzNMKsT3XNGMniGuQlfkBRtBmEyJopx1-NYJSHE0ZUlK5aHh8Sqee0JLNF7OjWB8LgTcwVy0hA20zPk32g9W4xmasxiO5YtLyiDirMX5FcjnUZEBU2ju95rUbySDK5oG3oFoN1Mg9iQC9KMAcUJLwSOQkrKkoZlWNFsJos6oRJtBiL1CKp6VN7QCTSzQJ0GSvrQQZ6J2RDz7HOKuDrPiWoHMOZOlho9NXkMKUVncO00BLUCRmChyRTM9RORTmafkVM2y1P8gbq1f0wApSaJJv9aFrSMBwFppTVRqXI2Uxa96V0Ks6T2eaUm6TTLEdbxS3JnTzpzVpuatjSe-roVoweMihQfSSWd6nel_IH0i1HsJgpG0bOGjwP9Yn7b1wdO8dk9v3kdUL0qzZSHDPZyByAiN9Re7lLkhVgfIIMSuNmPYkyJVpbKbTiWF4usTi7CrRAE9LHiRHLC7J6nUtyLXYwWfEl1d1qbkhP3k_H6FmOpCFvWXrn52lYLdCz5it29ZL0PTGtlDc-CYtmWZTg-ftH84ejFMxx4NnMHrqzN8G916-FzRGi-OYdvmyDAMy7HfbNO-_QVuNU3L)
