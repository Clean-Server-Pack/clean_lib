import { getSettings } from "../providers/settings/settings_manager";



export default function getImageType(image: string | undefined) {
  if(!image) return false;    
  const current_settings = getSettings();
  const is_link = image && typeof image === 'string' && (image.startsWith('https') || image.startsWith('nui://'));
  // is_local_images are just plain something.png etc 
  const is_inv_image = image && typeof image === 'string' && !image.startsWith('https');
  const is_icon = image && typeof image === 'string' && !image.startsWith('https') && !image.includes('.');

  if (is_link) {
    return {
      type: 'image',
      path: `${image}`,
    }
  }

  if (is_icon) {
    return {
      type: 'icon',
      path: image,
    }
  }

  if (is_inv_image) {
    return {
      type: 'image',
      path: `url(${current_settings.itemImgPath}${image})`,
    }
  }

  return {
    type: 'unknown',
    path: '',
  }
}
