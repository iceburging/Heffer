// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.noConflict() // prevents conflict with prototype

jQuery(document).ready(function() {
  //slideShow
  jQuery.fn.slideShow();
  // smooth image swap on details page
  jQuery.fn.imageSwap();
  // calculators
  jQuery.fn.anitaCalc();
  jQuery.fn.royceCalc();
  jQuery.fn.carriwellCalc();
  // accordion
  jQuery.fn.faqAccordion();
  // reveal js only content
  jQuery.fn.revealJavascriptOnlyContent();
  // tablesorter
  jQuery.fn.tableSorter();
})

