// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Copyright (c) 2013 Adam Roben <adam@roben.org>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE-CHROMIUM file.

#include "atom/browser/ui/inspectable_web_contents_view_mac.h"

#import <AppKit/AppKit.h>

#import "atom/browser/ui/cocoa/atom_inspectable_web_contents_view.h"
#include "atom/browser/ui/inspectable_web_contents.h"
#include "atom/browser/ui/inspectable_web_contents_view_delegate.h"
#include "base/strings/sys_string_conversions.h"

namespace atom {

InspectableWebContentsView* CreateInspectableContentsView(
    InspectableWebContentsImpl* inspectable_web_contents) {
  return new InspectableWebContentsViewMac(inspectable_web_contents);
}

InspectableWebContentsViewMac::InspectableWebContentsViewMac(
    InspectableWebContentsImpl* inspectable_web_contents)
    : inspectable_web_contents_(inspectable_web_contents),
      view_([[AtomInspectableWebContentsView alloc]
          initWithInspectableWebContentsViewMac:this]) {}

InspectableWebContentsViewMac::~InspectableWebContentsViewMac() {
  [view_ removeObservers];
  CloseDevTools();
}

gfx::NativeView InspectableWebContentsViewMac::GetNativeView() const {
  return view_.get();
}

void InspectableWebContentsViewMac::ShowDevTools() {
  [view_ setDevToolsVisible:YES];
}

void InspectableWebContentsViewMac::CloseDevTools() {
  [view_ setDevToolsVisible:NO];
}

bool InspectableWebContentsViewMac::IsDevToolsViewShowing() {
  return [view_ isDevToolsVisible];
}

bool InspectableWebContentsViewMac::IsDevToolsViewFocused() {
  return [view_ isDevToolsFocused];
}

void InspectableWebContentsViewMac::SetIsDocked(bool docked) {
  [view_ setIsDocked:docked];
}

void InspectableWebContentsViewMac::SetContentsResizingStrategy(
    const DevToolsContentsResizingStrategy& strategy) {
  [view_ setContentsResizingStrategy:strategy];
}

void InspectableWebContentsViewMac::SetTitle(const base::string16& title) {
  [view_ setTitle:base::SysUTF16ToNSString(title)];
}

}  // namespace atom
