# Salesforce Integration Patterns and Practices

Apex REST Callouts, Apex SOAP Callouts, Apex Web Services

<blockquote>
    <p>This is a.</p>
   t
</blockquote>

<p><code>There is a literal backtick (`) here.</code></p>

![Alt text](/path/to/img.jpg)

![Alt text](/path/to/img.jpg "Optional title")

<a href="http://www.youtube.com/watch?feature=player_embedded&v=YOUTUBE_VIDEO_ID_HERE
" target="_blank"><img src="http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

## Pattern Template

### Name

### Context

### Problem

### Forces

### Solution

### Sketch

### Results

### Sidebars


## Pattern Summary


## Pattern Approach
 * Data Integration
 * Process Integration

## Pattern Selection Guide

| **Pattern**       | **Scenario**          |
| ------------- |:-------------:|
| *Remote Process Invocation - Request and Reply*    | Salesforce invokes a process on a remote system, waits for completion of that process, and then tracks state based on the response from the remote system. |
| *Remote Process Invocation - Fire and Forget*  |  Salesforce invokes a process in a remote system but does not wait for completion of a process.  Instead, the remote process receives and acknowledges the request and then hands off control back to Salaeforce |
| *Batch Data Synchronization* | Data stored in Force.com should be created or refreshed to reflect updates from an external system, and when changes from Force.com should be sent to an external system.  Updates in either direction are done in batch manner.      |
| *Remote Call-In* | Data stored in Force.com is created, retrieved, updated, or deleted by a remote system. |
| *UI Update Based on Data Changes* | The Salesforce user interface must be automatically updated as a result of changes to Salesforce data. | 




