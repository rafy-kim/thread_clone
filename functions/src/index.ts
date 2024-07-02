/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();


export const onPostCreated = functions.firestore
  .document("posts/{postId}")
  .onCreate(async (snapshot, context) => {
    // await snapshot.ref.update({ hello: "from functions" });
    const post = snapshot.data();
    const db = admin.firestore();
    
    await db.collection("users").doc(post.userId).collection("posts").doc(snapshot.id).set({
       postId: snapshot.id,
       userName: post.userName,
       userImg: post.userImg,
       userId: post.userId,
       content: post.content,
      imgs: post.imgs,
      createdAt: post.createdAt,
    });
  });
