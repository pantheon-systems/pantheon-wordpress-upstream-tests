<?php

namespace PantheonSystems\PantheonWordPressUpstreamTests\Behat;

use Behat\Behat\Context\TranslatableContext;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext as BehatMinkContext;


class MinkContext extends BehatMinkContext {

  /**
   * Build URL, based on provided path.
   *
   * @param string $path Relative or absolute URL.
   * @return string
   */
  public function locatePath($path)
  {
    if (strtolower(substr($path, 0, '4')) === 'http') {
      return $path;
    }
    $ext = pathinfo($path, PATHINFO_EXTENSION);
    $url = $this->getMinkParameter('base_url');
    if (!empty(getenv('RELOCATED_WP_ADMIN')) && (strpos($path, 'wp-admin') !== false || in_array($ext, ['htm', 'html', 'md', 'php', 'txt'], true))) {
      $url = $url . 'wp';
    }
    return rtrim($url, '/') . '/' . ltrim($path, '/');
  }
}
