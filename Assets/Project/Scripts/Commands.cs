using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class Commands : MonoBehaviour
{
    // Image overlay for fade
    public RawImage fadeOutUIImage;
    // Rate at which things fade 
    public float fadeSpeed = 2.0f;

    /// <summary>
    /// Fade in or out  - 1 represents fade in, 0 represents fade out
    /// just a bit easier to understand than using a hoolean 
    /// </summary>
    public enum FadeDirection
    {
        In, //Alpha = 1
        Out // Alpha = 0
    }

    /// <summary>
    /// Fades in or out before loading the next scene
    /// </summary>
    /// <param name="fadeDirection">a fadedirection object that says in or out</param>
    /// <param name="nextScene">string scene name to load</param>
    /// <returns></returns>
    public IEnumerator LoadSceneWithFade(FadeDirection fadeDirection, string nextScene)
    {
        Debug.Log("yield start");
        yield return Fade(fadeDirection);
        Debug.Log("yield complete");
        SceneManager.LoadScene(nextScene);
    }

    public void StartSimulation()
    {
        Debug.Log("Start Simulation");
        StartCoroutine(LoadSceneWithFade(FadeDirection.In, "GameScene"));
    }

    public void MainMenu()
    {
        LoadSceneWithFade(FadeDirection.In, "Start");
    }

    public void QuitSimulation()
    {
        Application.Quit();
    }
    void OnEnable()
    {
        StartCoroutine(Fade(FadeDirection.Out));
    }

    private IEnumerator Fade(FadeDirection fadeDirection)
    {
        float alpha = (fadeDirection == FadeDirection.Out) ? 1 : 0;
        float fadeEndValue = (fadeDirection == FadeDirection.Out) ? 0 : 1;
        if (fadeDirection == FadeDirection.Out)
        {
            while (alpha >= fadeEndValue)
            {
                SetColorImage(ref alpha, fadeDirection);
                yield return null;
            }
            fadeOutUIImage.enabled = false;
        }
        else
        {
            fadeOutUIImage.enabled = true;
            while (alpha <= fadeEndValue)
            {
                SetColorImage(ref alpha, fadeDirection);
                yield return null;
            }
        }
    }

    private void SetColorImage(ref float alpha, FadeDirection fadeDirection)
    {
        fadeOutUIImage.color = new Color(fadeOutUIImage.color.r, fadeOutUIImage.color.g, fadeOutUIImage.color.b, alpha);
        alpha += Time.deltaTime * (1.0f / fadeSpeed) * ((fadeDirection == FadeDirection.Out) ? -1 : 1);
    }
}
