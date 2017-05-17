<?php

/*
 * This file is part of the Behat MinkExtension.
 * (c) Konstantin Kudryashov <ever.zet@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace PantheonSystems\PantheonWordPressUpstreamTests\Behat;

use Behat\Behat\Context\TranslatableContext;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext as BehatMinkContext;


class MinkContext extends BehatMinkContext {


    protected function detectRelocatedPage($page) {
      $page = ltrim($page, "/");
      $redirectable_paths = [
        'wp-admin',
        'wp-login.php'
      ];


        print_r("

$page

          ");

        foreach($redirectable_paths as $redirectable_path) {
          print_r($redirectable_path);
          print_r("

          ");

          if (strpos($page, $redirectable_path) === 0) {
              return TRUE;
          }

      }


    }

    public function assertPageAddress($page)
    {

        print_r($page);


        if ($this->detectRelocatedPage($page)) {
            $page = '/wp/' . ltrim($page, "/");
        }








      $this->assertSession()->addressEquals($this->locatePath($page));
    }


    public function visit($page)
    {

        if (strpos($page, 'p-admin')) {


            print_r("
asdf

        ");

            $this->visitPath('/wp/' . $page);
        } else {
            $this->visitPath($page);
        }


    }

}
