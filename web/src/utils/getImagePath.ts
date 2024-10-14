import { getSettings } from "../providers/settings/settings_manager";

async function checkImageExists(url: string) {
  try {
    const response = await fetch(url);
    return response.ok;
  } catch (error) {
    return false;
  }
}

export default async function getImageType(image: string | undefined) {
  if (!image) return false;
  const current_settings = getSettings();
  const is_link = image && typeof image === 'string' && (image.startsWith('https') || image.startsWith('nui://'));
  const is_inv_image = image && typeof image === 'string' && !image.startsWith('https') && !image.startsWith('nui://');
  const is_icon = image && typeof image === 'string' && !image.startsWith('https') && !image.includes('.');

  if (is_link) {
    return {
      type: 'image',
      path: `${image}`,
    };
  }

  if (is_icon) {
    return {
      type: 'icon',
      path: image,
    };
  }

  if (is_inv_image) {
    const extensions = ['.png', '.webp', '.jpg']; // Add more as needed
    for (const ext of extensions) {
      const fullPath = `${current_settings.itemImgPath}${image}${ext}`;
      const exists = await checkImageExists(fullPath);
      if (exists) {
        return {
          type: 'image',
          path: fullPath,
        };
      }
    }
    console.log(`[getImageType] Image not found: ${image}`);
  }

  return {
    type: 'unknown',
    path: '',
  };
}
